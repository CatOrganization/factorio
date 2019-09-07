
clean:
	rm -rf built
	$(MAKE) -C terraform clean

hello:
	GOOS=linux go build -o built/hello cmd/hello/hello.go

plan: hello
	$(MAKE) -C terraform plan

apply: hello
	$(MAKE) -C terraform apply

yes-apply: hello
	$(MAKE) -C terraform yes-apply
