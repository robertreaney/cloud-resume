FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get install openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt -subj "/C=US/ST=NorthCarolina/L=Raleigh/O=ReaneyConsulting/CN=robertreaney.com"