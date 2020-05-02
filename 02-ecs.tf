resource "aws_ecs_cluster" "tf-ecs-cluster" {
  name = "${var.resource_prefix}-cluster"
}

resource "aws_alb" "tf-alb" {
  name                       = "${var.resource_prefix}-alb"
  security_groups            = [aws_security_group.tf-alb-sg.id]
  subnets                    = flatten([aws_subnet.tf-subnet-1a.*.id, aws_subnet.tf-subnet-1c.*.id])
  internal                   = false
  enable_deletion_protection = false
}

resource "aws_alb_listener" "tf-alb-listener" {
  port              = "80"
  protocol          = "HTTP"

  load_balancer_arn = aws_alb.tf-alb.arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}
