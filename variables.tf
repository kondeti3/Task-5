variable "region" {
  description = "The AWS region"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket name for storing Terraform state files and QR code images"
  type        = string
}

variable "ses_email_address" {
  description = "The SES verified email address for sending emails"
  type        = string
}

variable "email_address" {
  description = "Email address to send QR code to."
  type        = string
}

variable "lambda_function_names" {
  type    = list(string)
  default = ["GenerateQRCodeLambda", "BatchProcessUsernameQRCodeLambda", "BatchProcessPhoneNumberQRCodeLambda"]
}

variable "s3_keys" {
  type    = list(string)
  default = ["Task-5/lambda_function.zip", "Task-5/username_lambda.zip", "Task-5/phonenumber_lambda.zip"]
}

variable "handlers" {
  type    = list(string)
  default = ["lambda_function.lambda_handler", "username_lambda.lambda_handler", "phonenumber_lambda.lambda_handler"]
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "function_definitions" {
  description = "List of Lambda function definitions"
  type = list(object({
    function_name = string
    s3_key        = string
    handler       = string
  }))
}
