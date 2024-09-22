provider "aws" {
  region = "eu-west-1"
}

variable "should_notify" {
  default = false
}

resource "aws_instance" "example" {
  ami           = "ami-0fed63ea358539e44"
  instance_type = "t2.micro"

  tags = {
    Name = "instance-conditional-exec"
  }
}

resource "null_resource" "run_local_exec" {
    count   = var.should_notify ? 1 : 0

    provisioner "local-exec" {
        command = "echo Instance created with ID: ${aws_instance.example.id} >> sample.log"
    }
}
