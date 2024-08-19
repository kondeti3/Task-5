provider "aws" {
  region = var.region
}

module "iam" {
  source = "./modules/iam"
  lambda_role_name = "lambda_execution_role"
}

module "lambda" {
  source                = "./modules/lambda"
  s3_bucket_name        = var.s3_bucket_name
  lambda_role_arn       = module.iam.lambda_execution_role_arn
  function_definitions = var.function_definitions
  environment_variables = var.environment_variables
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  region = var.region
  lambda_function_arn = module.lambda.lambda_arns[0]
  lambda_invoke_arn   = module.lambda.lambda_arns[0] 
}

module "sqs" {
  source = "./modules/sqs"
  username_lambda_function_arn = module.lambda.lambda_arns[1]
  phonenumber_lambda_function_arn = module.lambda.lambda_arns[2]
}

module "eventbridge" {
  source              = "./modules/eventbridge"
  lambda_role_arn   = module.iam.lambda_execution_role_arn
  username_sqs_arn     = module.sqs.username_queue_arn
  phone_number_sqs_arn = module.sqs.phonenumber_queue_arn
}

module "ses" {
  source       = "./modules/ses"
  region       = var.region
  email_address = var.email_address
}
