# Specify the provider and access details
resource "random_shuffle" "random_subnet" {
  input        = [for s in data.aws_subnet.public : s.id]
  result_count = 1
}

resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami           = data.aws_ami.ami.id
  count         = var.num_instances

  subnet_id              = random_shuffle.random_subnet.result[0]
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.KEY_NAME
  iam_instance_profile   = aws_iam_instance_profile.ecr_readOnly_profile.name


  provisioner "file" {
    content     = data.template_file.script.rendered
    destination = "$(pwd)/script.sh"
  }

  provisioner "file" {
    content     = data.template_file.docker_compose.rendered
    destination = "$(pwd)/docker-compose.yml"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo bash $(pwd)/script.sh"
    ]
  }

  connection {
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_KEY)
    host        = self.public_dns
  }

  tags = {
    Name = "${var.app}-ec2-${terraform.workspace}-${format("%02d", count.index + 1)}"
  }
}
