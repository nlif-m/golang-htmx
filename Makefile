.POSIX:
.SUFFIX:
.PHONY: all vet fmt windows_amd64 linux_arm linux_amd64 crossplatform atomgen
GOFLAGS=-tags netgo -ldflags '-extldflags "-static"'


all: htmx

htmx: vet test
	go build ${GOFLAGS} -o "$@"

vet: fmt
	go vet ./...

fmt:
	go fmt ./...

test:
	go test ./...
