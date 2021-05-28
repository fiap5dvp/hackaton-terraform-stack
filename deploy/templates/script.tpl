# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

login=$(aws ecr get-login --region=us-east-1)
login=$(echo $login | sed 's/-e none/ /g' | tee)
echo $login | bash

docker-compose up -d

echo "DONE!!"