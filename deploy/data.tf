data "template_file" "script" {
  template = file("${path.module}/templates/script.tpl")
}

data "aws_vpc" "vpc" {
  id = var.vpc_id

}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.all.ids
  id       = each.value
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-*x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["591542846629"] # Amazon
}

data "external" "last_tag" {
  program = [
    "aws", "ecr", "describe-images",
    "--repository-name", var.project,
    "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageTags)}",
  ]
}

data "template_file" "docker_compose" {
  template = file("${path.module}/templates/docker-compose.tpl")

  vars = {
    REPO_URL = var.ECR_REGISTRY
    TAG      = data.external.last_tag.result.tags
  }
}
