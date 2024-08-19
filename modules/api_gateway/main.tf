resource "aws_api_gateway_rest_api" "qr_code_api" {
  name        = "QRCodeGeneratorAPI"
  description = "API to generate QR codes based on username or phone number"
}

resource "aws_api_gateway_resource" "generate" {
  rest_api_id = aws_api_gateway_rest_api.qr_code_api.id
  parent_id   = aws_api_gateway_rest_api.qr_code_api.root_resource_id
  path_part   = "generate"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.qr_code_api.id
  resource_id   = aws_api_gateway_resource.generate.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id = aws_api_gateway_rest_api.qr_code_api.id
  resource_id = aws_api_gateway_resource.generate.id
  http_method = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.post_integration]
  rest_api_id = aws_api_gateway_rest_api.qr_code_api.id
  stage_name = "prod"
}
