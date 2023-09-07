FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime
EXPOSE 9000
WORKDIR /wd
RUN apt update && \
    apt install -y ffmpeg && \
    pip install setuptools-rust

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py app.py
COPY recording.wav recording.wav