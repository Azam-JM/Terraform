provider "aws" {
    region =  "eu-west-1"
}

resource "aws_instance" "instance" {
    ami           = "ami-0fed63ea358539e44"
    instance_type = "t2.micro"
}