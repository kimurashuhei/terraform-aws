resource "aws_ecs_cluster" "tf-ecs-cluster" {
  name = "${var.resource_prefix}-cluster"
}

resource "aws_iam_role" "tf-ecs-role" {
  name               = "tf-ecs-role"
  assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_iam_role_policy_attachment" "ecs-task-exec-role-policy" {
  role       = aws_iam_role.tf-ecs-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs-task-exec-role-policy-s3" {
  role       = aws_iam_role.tf-ecs-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-task-exec-role-policy-ssm" {
  role       = aws_iam_role.tf-ecs-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
