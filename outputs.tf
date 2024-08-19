output "api_gateway_url" {
  description = "The URL for the API Gateway"
  value       = module.api_gateway.api_url
}

output "lambda_function_arns" {
  description = "The ARNs of all Lambda functions"
  value = module.lambda.lambda_arns
}
