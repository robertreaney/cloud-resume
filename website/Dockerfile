FROM python:3.9-slim-buster

EXPOSE 5000
WORKDIR /wd

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY utils ./utils
COPY app.py ./app.py
COPY static ./static
