terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "local" {
  instance_type = "t2.micro"
  ami           = "ami-0fed63ea358539e44"
  tags = {
    Name = "local-ec2-with-script"
  }

  provisioner "local-exec" {
    command = "sh ./post_deploy.sh"
  }
}
