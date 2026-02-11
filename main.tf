########################################
# 1️⃣ EC2 Instance
########################################
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

resource "aws_security_group" "my-new-security-group" {
  name        = "web_server_inbound"
  description = "Allow inbound traffic on tcp/443"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow 443 from the Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web_server_inbound"
    Purpose = "Intro to Resource Blocks Lab"
  }
}