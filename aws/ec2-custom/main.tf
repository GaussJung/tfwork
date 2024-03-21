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

// ami-0a55ba1c20b74fc30 : Ubuntu 22.04 for Arm64 
resource "aws_instance" "my_server" {

  ami = "ami-0a55ba1c20b74fc30"

  instance_type = "t4g.nano"

  key_name = "myawskeyname"

  vpc_security_group_ids = ["sg-025f67----7509eed1]

  tags = {
    Name = "TF-AppCustomInstance"
  }

}