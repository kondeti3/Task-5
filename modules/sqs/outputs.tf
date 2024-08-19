output "username_queue_arn" {
  description = "The ARN of the SQS queue for username QR codes"
  value       = aws_sqs_queue.username_queue.arn
}

output "phonenumber_queue_arn" {
  description = "The ARN of the SQS queue for phone number QR codes"
  value       = aws_sqs_queue.phonenumber_queue.arn
}
