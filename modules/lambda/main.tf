resource "aws_lambda_function" "lambda_functions" {
  count         = length(var.function_definitions)
  function_name = var.function_definitions[count.index].function_name
  s3_bucket     = var.s3_bucket_name
  s3_key        = var.function_definitions[count.index].s3_key
  handler       = var.function_definitions[count.index].handler
  runtime       = "python3.8"
  role          = var.lambda_role_arn

  environment {
    variables = var.environment_variables
  }
}