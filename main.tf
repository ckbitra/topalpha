resource "aws_instance" "this" {
  ami           = "ami-0c1fe732b5494dc14"  # Your AMI ID (e.g., Amazon Linux 2023)
  instance_type = "t3.micro"

  subnet_id = "subnet-061c2ac004db6dcd6"  # Existing subnet ID

  tags = {
    Name        = "MyEC2Instance"
    Environment = "dev"
    Owner       = "Bitra Team"
  }
}


variable "instance_count" {
  default = 3
}

resource "aws_instance" "web" {
  count = var.instance_count

  ami           = "ami-0c1fe732b5494dc14"
  instance_type = "t3.micro"
  subnet_id     = "subnet-065963ad393ab557b"

  tags = {
    Name = "web-server-${count.index + 1}"  # web-server-1, -2, -3
  }
}
