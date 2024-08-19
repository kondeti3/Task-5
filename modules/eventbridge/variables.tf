variable "lambda_role_arn" {
  description = "The ARN of the IAM role used by Lambda functions"
  type        = string
}

variable "username_sqs_arn" {
  description = "The ARN of the SQS queue for username QR codes"
  type        = string
}

variable "phone_number_sqs_arn" {
  description = "The ARN of the SQS queue for phone number QR codes"
  type        = string
}
