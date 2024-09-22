provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0fed63ea358539e44"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "curl -X POST -d 'instance_id=${self.id}' https://leetcode.com/problems/contains-duplicate/description/"
  }

  tags = {
    Name = "instance-with-api-call"
  }
}
