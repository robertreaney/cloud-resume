# robert-resume

## Get Into EC2

1. ssh keygen in `~/.ssh`
```ssh-keygen -t rsa -b 4096```
2. terraform apply
3. `ssh -i ~/.ssh/id_rsa ubuntu@ec2_public_key`
4. Set environment variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
5. run `ec2_startup.sh`
6. startup the container with `sudo docker run -it -p 80:5000 container_image_name /bin/bash`
7. inside the container start the web server `gunicorn --bind 0.0.0.0:5000 app:app`
8. go to your devbox and goto ec2_public_ip:80