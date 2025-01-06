terraform {
  backend "s3" {
    bucket         = "sandra-terraform-state-bucket"
    key            = "sandra-cluster/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "sandra-terraform-locks"

    region  = "us-east-1"
  
  }
}