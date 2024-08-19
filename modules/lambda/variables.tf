variable "lambda_role_arn" {
  description = "The ARN of the IAM role used by Lambda functions"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket where Lambda code is stored"
  type        = string
}

variable "environment_variables" {
  description = "A map of environment variables for the Lambda functions"
  type        = map(string)
}

variable "function_definitions" {
  type = list(object({
    function_name = string
    s3_key        = string
    handler       = string
  }))
}