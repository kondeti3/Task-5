# Define the EventBus
resource "aws_cloudwatch_event_bus" "qr_code_event_bus" {
  name = "NewQRCodeEventBus"
}

# Define the EventBridge rule for username events
resource "aws_cloudwatch_event_rule" "username_rule" {
  name        = "NewUsernameRule"
  event_bus_name = aws_cloudwatch_event_bus.qr_code_event_bus.name
 event_pattern = jsonencode({
    "source": ["com.qrcode.username"],
    "detail-type": ["QRCodeGeneration"],
    "detail": {
      "username": [{"exists": true}]
    }
  })
}

# Define the EventBridge rule for phone number events
resource "aws_cloudwatch_event_rule" "phone_number_rule" {
  name        = "NewPhoneNumberRule"
  event_bus_name = aws_cloudwatch_event_bus.qr_code_event_bus.name
  event_pattern = jsonencode({
    "source": ["com.qrcode.phoneNumber"],
    "detail-type": ["QRCodeGeneration"],
    "detail": {
      "phoneNumber": [{"exists": true}]
    }
  })
}

# Define the target for the username rule
resource "aws_cloudwatch_event_target" "username_target" {
  rule       = aws_cloudwatch_event_rule.username_rule.name
  event_bus_name = aws_cloudwatch_event_bus.qr_code_event_bus.name
  arn        = var.username_sqs_arn
  target_id  = "username_queue"
  depends_on = [aws_cloudwatch_event_rule.username_rule]
}

# Define the target for the phone number rule
resource "aws_cloudwatch_event_target" "phone_number_target" {
  rule       = aws_cloudwatch_event_rule.phone_number_rule.name
  event_bus_name = aws_cloudwatch_event_bus.qr_code_event_bus.name
  arn        = var.phone_number_sqs_arn
  target_id  = "phonenumber_queue"
  depends_on = [aws_cloudwatch_event_rule.phone_number_rule]
}
