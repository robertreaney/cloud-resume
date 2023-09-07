#!/bin/bash

ssh -i ~/.ssh/id_rsa ubuntu@52.54.162.179 -o StrictHostKeyChecking=no "bash -s" << EOF
#!/bin/bash

date +"%Y-%m-%d %H:%M:%S" > ~/refresh-proof.log
cd cloud-resume
git pull
docker compose up -d --build
EOF