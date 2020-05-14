provider "aws" {
  region = var.region
  version = "2.43"
}

provider "random" {
  version = "2.2.1"
}