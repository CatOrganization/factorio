module "hello_lambda" {
  source = "./modules/lambda"

  name = "hello"
}


module "new_lambda" {
  source = "./modules/lambda"

  name = "new"
}