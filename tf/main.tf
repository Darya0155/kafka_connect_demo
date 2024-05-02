provider "aws" {
  region = var.data.region
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}