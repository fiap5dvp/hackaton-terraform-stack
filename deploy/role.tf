resource "aws_iam_role" "ecr_readOnly_role" {
  name = "${terraform.workspace}-ecr_readOnly_role-${var.PROJECT_NAME}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${terraform.workspace}-ecr_readOnly_role-${var.PROJECT_NAME}"
  }
}

resource "aws_iam_instance_profile" "ecr_readOnly_profile" {
  name = "${terraform.workspace}-ecr_readOnly_profile-${var.PROJECT_NAME}"
  role = aws_iam_role.ecr_readOnly_role.name
}

resource "aws_iam_role_policy" "ecr_readOnly_policy" {
  name = "${terraform.workspace}-ecr_readOnly_policy-${var.PROJECT_NAME}"
  role = aws_iam_role.ecr_readOnly_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage",
                "ecr:GetLifecyclePolicy",
                "ecr:GetLifecyclePolicyPreview",
                "ecr:ListTagsForResource",
                "ecr:DescribeImageScanFindings"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
