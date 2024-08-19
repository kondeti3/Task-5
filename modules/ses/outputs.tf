output "ses_email_identity_arn" {
  description = "The ARN of the SES email identity."
  value       = aws_ses_email_identity.ses_email.arn
}
