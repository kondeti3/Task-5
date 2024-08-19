output "lambda_arns" {
  description = "The ARNs of all Lambda functions"
  value = [for fn in aws_lambda_function.lambda_functions : fn.arn]
}
