# create ecr repository for every member

resource "aws_ecr_repository" "tf-ecr" {
  name = "${var.resource_prefix}"
}

