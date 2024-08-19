variable "username_lambda_function_arn" {
  description = "ARN of the Lambda function for processing username QR codes"
  type        = string
}

variable "phonenumber_lambda_function_arn" {
  description = "ARN of the Lambda function for processing phone number QR codes"
  type        = string
}
