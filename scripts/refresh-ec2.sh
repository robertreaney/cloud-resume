#!/bin/bash

ssh -i ~/.ssh/id_rsa ubuntu@52.54.162.179 -o StrictHostKeyChecking=no "bash -s" << EOF
#!/bin/bash

date +"%Y-%m-%d %H:%M:%S" > ~/refresh-proof.log
git clone https://github.com/robertreaney/cloud-resume.git
EOF