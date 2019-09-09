HANDLERS:=$(shell git ls-files cmd/ | cut -d/ -f2 | uniq )
BINARIES:=$(patsubst %, built/%, ${HANDLERS})

clean:
	rm -rf built
	$(MAKE) -C terraform clean

#.PRECIOUS: built/%
built/%: cmd/%/*.go
	GOOS=linux go build -o built/$* cmd/$*/main.go

build: ${BINARIES}

plan: build
	$(MAKE) -C terraform plan

apply: build
	$(MAKE) -C terraform apply

yes-apply: build
	$(MAKE) -C terraform yes-apply
