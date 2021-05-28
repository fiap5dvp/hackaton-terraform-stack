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
  source        = "./deploy"
  ECR_REGISTRY  = "129824431449.dkr.ecr.us-east-1.amazonaws.com/hackaton"
  num_instances = 3
  app           = "web"
  vpc_id        = "vpc-3e139844"
  project       = "hackaton"
  PATH_TO_KEY   = "/home/ericrsilva/.ssh/fiap-lab.pem"
}
