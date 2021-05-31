terraform {
  backend "s3" {
    bucket = var.BUCKET_NAME
    key    = "state/hackaton-cicd-deploy"
    region = "us-east-1"
  }
}
