provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "acm"
  region = "us-east-1"
}
