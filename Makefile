
clean:
	rm -f hello
	rm -f hello.zip
	$(MAKE) -C terraform clean

hello:
	GOOS=linux go build -o hello cmd/hello/hello.go

plan: hello
	$(MAKE) -C terraform plan

apply: hello
	$(MAKE) -C terraform apply

yes-apply: hello
	$(MAKE) -C terraform yes-apply
