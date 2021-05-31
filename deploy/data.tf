data "template_file" "user_data" {
  template = file("${path.module}/templates/userdata.tpl")
  vars = {
    REPO_URL       = data.aws_ecr_repository.repository.repository_url
    USER_NAME      = var.INSTANCE_USERNAME
    PROJECT_NAME   = var.PROJECT_NAME
    CONTAINER_PORT = var.CONTAINER_PORT
  }
}

data "aws_vpc" "vpc" {
  id = var.VPC_ID
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "Public"
  }
}

data "aws_ecr_repository" "repository" {
  name = var.PROJECT_NAME
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
