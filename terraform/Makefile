TF_VERSION=0.12.8
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    ZIP_FILE=terraform_${TF_VERSION}_linux_amd64.zip
endif
ifeq ($(UNAME_S),Darwin)
    ZIP_FILE=terraform_${TF_VERSION}_darwin_amd64.zip
endif

AWS_DEFAULT_REGION ?= us-east-2

bin/terraform:
	mkdir -p bin
	curl -O "https://releases.hashicorp.com/terraform/${TF_VERSION}/${ZIP_FILE}"
	unzip ${ZIP_FILE}
	rm ${ZIP_FILE}
	mv terraform bin/

clean:
	rm -rf bin/terraform
	rm -f plan_pipe
	rm -f plan.txt

terraform-%.tf:
	AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} ENV=$* envtpl --output ${CURDIR}/terraform-$*.tf ${CURDIR}/terraform.tf.tmpl

init: bin/terraform
	bin/terraform init

pull: bin/terraform
	@bin/terraform state pull

plan_pipe:
	mkfifo plan_pipe

validate: bin/terraform init
	bin/terraform validate

plan: bin/terraform init pull plan_pipe
	tee plan.txt < plan_pipe &

	@bin/terraform plan \
		-no-color > plan_pipe

apply: bin/terraform init
	@bin/terraform apply

yes-apply: bin/terraform init
	@bin/terraform apply \
		-auto-approve