#!/bin/bash

ssh -v -i ~/.ssh/id_rsa ubuntu@3.82.255.107 -o StrictHostKeyChecking=no "bash -s" << EOF
#!/bin/bash

date +"%Y-%m-%d %H:%M:%S" > ~/refresh-proof.log
cd ~/cloud-resume
git checkout main
git pull
sudo docker compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d --remove-orphans
EOF