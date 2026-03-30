package settings

import (
	"os"
	"runtime"
	"time"

	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

var (
	// twheel:
	Interval = 250 * time.Millisecond
	NLevels  = 8
	NBuckets = 100
	MaxTTL   = 24 * time.Hour * 1000 // ≈ 3 year

	// cache:
	ShardsFactor = 4
	CoreNumber   = runtime.GOMAXPROCS(0)
	ShardsNumber = ShardsFactor * CoreNumber

	// dumper:
	DumpInterval = 1 * time.Hour
	DumpBufSize  = 5 * ShardsNumber
	ImagePath    = os.Getenv("DUMPER_PATH")

	// server:
	ServerAddress = ":8080"
	MaxObjectSize = 10 * 1024 * 1024 // 10 MiB
)

func WheelProps() twheel.Props {
	return twheel.Props{
		Interval: Interval,
		NLevels:  NLevels,
		NBuckets: NBuckets,
		MaxTTL:   MaxTTL,
	}
}
