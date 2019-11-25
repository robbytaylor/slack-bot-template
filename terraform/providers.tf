provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "acm"
  region = "us-east-1"
}
