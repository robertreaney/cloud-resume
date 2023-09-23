# Cloud Resume

This is a work in progress repository to display data science and machine learning content in a public setting. 

# Status

Currently prod has a prototype resume scaffolding with sections and buttons for the ASR chat-gpt plugin. I have almost figured out https for prod to give access to visitor's microphone. In dev I have the basics of ASR/chatgpt setup to start that speech-to-gpt service. I need to clean up some of the file communications as it is just working with a "smoke test" right now. Also I need to put the asr model (whisper) into lambda to avoid a huge EC2 bill.

# Production

Public Domain: `robertreaney.com`

# Local Developer Mode

0. Configure AWS CLI as your credentials will be shared with the local services.
1. `docker compose up --build`
    - `Ctrl+Shift+B` in VSCode works as shortcut

# Get Into EC2

1. ssh keygen in `~/.ssh`
```ssh-keygen -t rsa -b 4096```
2. terraform apply
3. `ssh -i ~/.ssh/id_rsa ubuntu@3.82.255.107 -o StrictHostKeyChecking=no`
4. Set environment variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
5. run `ec2_startup.sh`
6. startup the container with `sudo docker run -it -p 80:5000 container_image_name /bin/bash`
7. inside the container start the web server `gunicorn --bind 0.0.0.0:5000 app:app`
8. go to your devbox and goto ec2_public_ip:80

# current CA state

- spin up stack on EC2 instance in cert mode

docker compose -f docker-compose.yml -f docker-compose.cert.yml up --build -d --remove-orphans

- docker exec -it nginx-server /bin/bash
- apt-get update
- apt-get install certbot
- certbot certonly --webroot -w /static -d robertreaney.com -v --cert-name robertreaney.com
- /etc/letsencrypt/archive/robertreaney.com should have keys in it
- /etc/letsencrypt/live/robertreaney.comy has symbolic link to keys