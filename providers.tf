provider "aws" {
  version    = "2.24.0"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
