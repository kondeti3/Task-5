variable "lambda_function_arn" {
  description = "The ARN of the Lambda function that API Gateway will invoke"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The invoke ARN of the Lambda function that API Gateway will invoke"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}
