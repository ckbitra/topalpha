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


# 1️⃣ S3 bucket
resource "aws_s3_bucket" "my_new_bucket" {
  bucket = "my-new-tf-test-bucket-bryan"

  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Intro to Resource Blocks Lab"
  }
}

# 2️⃣ Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "my_new_bucket_acl" {
  bucket = aws_s3_bucket.my_new_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# 3️⃣ IAM group for developers
resource "aws_iam_group" "developers" {
  name = "developers"
}

# 4️⃣ IAM policy for S3 access
resource "aws_iam_policy" "dev_s3_access" {
  name        = "DeveloperS3Access"
  description = "Allow developers to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.my_new_bucket.arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.my_new_bucket.arn}/*"
      }
    ]
  })
}

# 5️⃣ Attach policy to developer group
resource "aws_iam_group_policy_attachment" "dev_group_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.dev_s3_access.arn
}

# 6️⃣ Create multiple IAM users
resource "aws_iam_user" "developers" {
  for_each = toset(["developer1", "developer2", "developer3"])
  name     = each.key
}

# 7️⃣ Add all users to the developers group
resource "aws_iam_user_group_membership" "dev_membership" {
  for_each = toset(["developer1", "developer2", "developer3"])
  user     = each.key
  groups   = [aws_iam_group.developers.name]
}
