#!/bin/bash
set -o xtrace 

curl -sSL https://get.docker.com/ | sudo sh
sudo yum install awscli -y
sudo usermod -aG docker ${USER_NAME}

login=$(aws ecr get-login --region=us-east-1)
login=$(echo $login | sed 's/-e none/ /g' | tee)
echo $login | bash

TAG=$(aws ecr describe-images --region=us-east-1 --output json --repository-name ${ENV}-${PROJECT_NAME} --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' --output=text)
dockerImage=${REPO_URL}:"$TAG"
docker pull $dockerImage

docker run -d -p 80:${CONTAINER_PORT} $dockerImage

echo "DONE!!"