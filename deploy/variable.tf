variable "KEY_NAME" {
  default = "fiap-lab"
}

variable "PATH_TO_KEY" {
  default = "/app/.ssh/fiap-lab.pem"
}
variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "ECR_REGISTRY" {
}

variable "instance_type" {
  default = "t3.small"
}

variable "project" {
}

variable "num_instances" {

}

variable "vpc_id" {

}

variable "app" {
}
