resource "aws_sqs_queue" "username_queue" {
  name = "username_queue"
}

resource "aws_sqs_queue" "phonenumber_queue" {
  name = "phonenumber_queue"
}

resource "aws_lambda_event_source_mapping" "username_queue_mapping" {
  event_source_arn = aws_sqs_queue.username_queue.arn
  function_name    = var.username_lambda_function_arn
  enabled          = true
}

resource "aws_lambda_event_source_mapping" "phonenumber_queue_mapping" {
  event_source_arn = aws_sqs_queue.phonenumber_queue.arn
  function_name    = var.phonenumber_lambda_function_arn
  enabled          = true
}
