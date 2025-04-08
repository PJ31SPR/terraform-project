# Provider Configuration
provider "aws" {
    region = "eu-west-2"  
}

# Backend Configuration for Remote State
terraform {
    backend "s3" {
        bucket = "patsy-terraform-bucket"  
        key    = "terraform.tfstate"       # Name of the state file
        region = "eu-west-2"              
    }
}