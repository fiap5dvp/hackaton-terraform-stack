data "template_file" "script" {
  template = file("${path.module}/script.sh.tpl")
  vars = {
    ECR_REGISTRY = "${var.ECR_REGISTRY}"
  }
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "${var.project}"
  }
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
