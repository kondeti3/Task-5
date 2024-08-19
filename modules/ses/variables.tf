variable "email_address" {
  description = "The SES verified email address"
  type        = string
}

variable "sns_topic_arn" {
  description = "The SNS Topic ARN for SES notifications"
  type        = string
}

variable "region" {
  description = "The AWS region where SES is used"
  type        = string
}
