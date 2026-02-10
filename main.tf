resource "aws_instance" "example" {
  ami           = "ami-0c1fe732b5494dc14"  # Your AMI ID (e.g., Amazon Linux 2023)
  instance_type = "t3.micro"

  subnet_id = "subnet-065963ad393ab557b"  # Existing subnet ID

  tags = {
    Name        = "MyEC2Instance"
    Environment = "dev"
    Owner       = "Bitra Team"
  }
}
