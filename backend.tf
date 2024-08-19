terraform {
  backend "s3" {
    bucket = "qr-code-generator-007"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}
