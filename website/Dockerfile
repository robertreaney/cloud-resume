FROM python:3.9-slim-buster

WORKDIR /wd

COPY static ./static
COPY utils ./utils
COPY requirements.txt ./requirements.txt
COPY app.py ./app.py

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000