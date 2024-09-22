provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "new_instance" {
    instance_type = "t2.micro"
    ami           = "ami-0fed63ea358539e44"
    tags = {
        Name = "local-ec2"
    }

    provisioner "local-exec" {
        command = "echo instance created: ${self.id}"
    }

    provisioner "local-exec" {
      when    = "destroy"
      command = "echo instance destroyed: ${self.id} >> destroy.log"
    }
}
