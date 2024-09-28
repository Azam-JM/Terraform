provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "web" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  subnet_id = var.subnet_id_value
}