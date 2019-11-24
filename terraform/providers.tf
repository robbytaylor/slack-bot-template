provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  alias  = "acm"
  region = "us-east-1"
}
