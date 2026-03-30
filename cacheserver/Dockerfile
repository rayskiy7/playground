FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY src/go.mod src/go.sum ./
RUN ls -la
RUN go mod download
COPY src/ .
RUN CGO_ENABLED=0 GOOS=linux go build -o /cacheserver ./cmd/main.go


FROM alpine:latest
WORKDIR /root/
COPY --from=builder /cacheserver .
RUN mkdir -p /data
ENV DUMPER_PATH=/data/dump.bin
EXPOSE 8080

ENTRYPOINT ["./cacheserver"]