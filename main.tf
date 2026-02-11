resource "aws_instance" "this" {
  ami           = "ami-0c1fe732b5494dc14" # Your AMI ID (e.g., Amazon Linux 2023)
  instance_type = "t3.micro"

  subnet_id = "subnet-07b2351cc4577c5ac" # Existing subnet ID

  tags = {
    Name        = "MyEC2Instance"
    Environment = "dev"
    Owner       = "Bitra Team"
  }
}


resource "aws_s3_bucket" "my-new-S3-bucket" {
  bucket = "my-new-tf-test-bucket-bitra2342o341234"

  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Intro to Resource Blocks Lab"
  }
}

resource "aws_s3_bucket_ownership_controls" "my_new_bucket_acl" {
  bucket = aws_s3_bucket.my-new-S3-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
