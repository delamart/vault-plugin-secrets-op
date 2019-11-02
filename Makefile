GOARCH = amd64

UNAME = $(shell uname -s)

ifndef OS
	ifeq ($(UNAME), Linux)
		OS = linux
	else ifeq ($(UNAME), Darwin)
		OS = darwin
	endif
endif

.DEFAULT_GOAL := all

all: fmt build start

build:
	GOOS=$(OS) GOARCH="$(GOARCH)" go build -o build/op cmd/op/main.go

start:
	vault server -dev -dev-root-token-id=root -dev-plugin-dir=./build

enable:
	vault secrets enable op

clean:
	rm -f ./build/op

fmt:
	go fmt $$(go list ./...)

.PHONY: build clean fmt start enable