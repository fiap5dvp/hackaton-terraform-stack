provider "aws" {
  region  = "us-east-1"
  profile = "ericrsilva"
}

terraform {
  backend "s3" {
    bucket  = "5dvp-terraform-grp4"
    key     = "state/hackaton-cicd-deploy"
    region  = "us-east-1"
    profile = "ericrsilva"
  }
}


module "deploy_python" {
  source       = "./deploy"
  VPC_ID       = "vpc-3e139844"
  PROJECT_NAME = "hackaton"
}

output "elb-dns" {
  value = module.deploy_python.elb_public
}
