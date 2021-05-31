variable "KEY_NAME" {
  default = "fiap-lab"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "ECR_REGISTRY" {
}

variable "INSTANCE_TYPE" {
  default = "t3.small"
}

variable "CONTAINER_PORT" {
  default = 5000
}

variable "PROJECT_NAME" {
}

variable "NUM_INSTANCES" {
  default = 1
}

variable "VPC_ID" {

}

variable "APP" {
}
