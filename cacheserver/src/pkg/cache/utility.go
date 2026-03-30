package cache

import (
	"bufio"
	"context"
	"encoding/binary"
	"io"
	"time"
)

type record struct {
	key     string
	value   []byte
	expires time.Time
}

// [8b: UnixNano] [4b: len(key)] [key...] [4b: len(value)] [value...]
func serializeRecord(r record) []byte {
	keyLen := len(r.key)
	valLen := len(r.value)
	buf := make([]byte, 8+4+keyLen+4+valLen)

	var nano int64
	if !r.expires.IsZero() {
		nano = r.expires.UnixNano()
	}

	binary.LittleEndian.PutUint64(buf[0:8], uint64(nano))
	binary.LittleEndian.PutUint32(buf[8:12], uint32(keyLen))
	copy(buf[12:12+keyLen], r.key)

	offset := 12 + keyLen
	binary.LittleEndian.PutUint32(buf[offset:offset+4], uint32(valLen))
	copy(buf[offset+4:offset+4+valLen], r.value)

	return buf
}

func deserializeEntries(ctx context.Context, r io.Reader) <-chan record {
	ch := make(chan record, 128)

	go func() {
		defer close(ch)
		reader := bufio.NewReader(r)

		for {
			select {
			case <-ctx.Done():
				return
			default:
				// 1. Time
				var nano uint64
				if err := binary.Read(reader, binary.LittleEndian, &nano); err != nil {
					return // EOF или ошибка
				}

				// 2. Key length
				var keyLen uint32
				if err := binary.Read(reader, binary.LittleEndian, &keyLen); err != nil {
					return
				}

				// Key itself
				key := make([]byte, keyLen)
				if _, err := io.ReadFull(reader, key); err != nil {
					return
				}

				// 3. Value length
				var valLen uint32
				if err := binary.Read(reader, binary.LittleEndian, &valLen); err != nil {
					return
				}

				// Value itself
				value := make([]byte, valLen)
				if _, err := io.ReadFull(reader, value); err != nil {
					return
				}

				var expires time.Time
				if nano != 0 {
					expires = time.Unix(0, int64(nano))
				}

				select {
				case ch <- record{
					key:     string(key),
					value:   value,
					expires: expires,
				}:
				case <-ctx.Done():
					return
				}
			}
		}
	}()

	return ch
}

func rottenExpirationTime(ts time.Time, start time.Time) bool {
	return !ts.IsZero() && ts.Before(start)
}
