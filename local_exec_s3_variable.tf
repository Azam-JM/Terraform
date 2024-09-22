resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-maza"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "echo S3 bucket: ${aws_s3_bucket.example.bucket}"

  }
}
