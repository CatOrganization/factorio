
clean:
	rm -f hello
	$(MAKE) -C terraform clean

hello:
	GO111MODULE=on GOOS=linux go build -o hello hello.go

plan: hello
	$(MAKE) -C terraform plan

apply: hello
	$(MAKE) -C terraform apply

yes-apply: hello
	$(MAKE) -C terraform yes-apply