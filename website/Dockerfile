FROM python:3.9-slim-buster

WORKDIR /wd

ENV FLASK_APP=/wd/app.py
ENV FLASK_ENV=production
EXPOSE 8000

COPY static /wd/static
COPY app.py /wd/app.py
COPY audio.py /wd/audio.py
COPY aws_s3.py /wd/aws_s3.py
COPY requirements.txt /wd/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]