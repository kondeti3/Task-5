output "qr_code_event_bus_arn" {
  description = "The ARN of the EventBridge event bus"
  value       = aws_cloudwatch_event_bus.qr_code_event_bus.arn
}
