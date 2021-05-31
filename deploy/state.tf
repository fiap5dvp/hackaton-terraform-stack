terraform {
  backend "s3" {
    bucket = "5dvp-terraform-grp4"
    key    = "state/hackaton-cicd-deploy"
    region = "us-east-1"
  }
}
