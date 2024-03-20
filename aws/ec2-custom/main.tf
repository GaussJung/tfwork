// 버전에 유의해야함 : 5.0 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

// us-east-1 : N-버지니아 
provider "aws" {
  region = "us-east-1"
}

// ami-0568072f574d822a4 : Ubuntu 22.04  
resource "aws_instance" "app_server" {
  ami = "ami-0568072f574d822a4"
  instance_type = "t4g.micro"

  tags = {
    Name = "TF-AppCustomInstance"
  }
}