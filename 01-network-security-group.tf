# A security group for the application-load-balancer so it is accessible via the web
resource "aws_security_group" "tf-alb-sg" {
  name        = "${var.resource_prefix}-alb-sg"
  vpc_id      = aws_vpc.tf-vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A security group for the ecs
resource "aws_security_group" "tf-ecs-sg" {
  name        = "${var.resource_prefix}-ecs-sg"
  vpc_id      = aws_vpc.tf-vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

