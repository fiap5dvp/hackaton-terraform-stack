# Specify the provider and access details
resource "random_shuffle" "random_subnet" {
  input        = [for s in data.aws_subnet.public : s.id]
  result_count = 1
}

resource "aws_instance" "web" {
  instance_type = var.INSTANCE_TYPE
  ami           = data.aws_ami.ami.id
  count         = var.NUM_INSTANCES

  subnet_id              = random_shuffle.random_subnet.result[0]
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.KEY_NAME
  iam_instance_profile   = aws_iam_instance_profile.ecr_readOnly_profile.name
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "${var.PROJECT_NAME}-ec2-${terraform.workspace}-${format("%02d", count.index + 1)}"
  }
}
