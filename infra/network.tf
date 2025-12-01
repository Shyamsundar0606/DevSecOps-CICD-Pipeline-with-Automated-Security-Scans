# Use the default VPC in your AWS account
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group for the app
resource "aws_security_group" "app_sg" {
  name        = "devsecops-demo-sg"
  description = "Allow HTTP access to app"
  vpc_id      = data.aws_vpc.default.id

  # Ingress: allow port 5000 from anywhere (Checkov will complain later = good for demo)
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress: allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
