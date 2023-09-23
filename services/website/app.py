from flask import Flask, request, send_file, jsonify
import os
import requests
import openai
from time import sleep

try:
    from .utils.aws_s3 import AWSS3
    from .utils.audio import Audio
except:
    from utils.aws_s3 import AWSS3
    from utils.audio import Audio
import logging
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)
s3 = AWSS3()
audio = Audio()
logging.basicConfig(level=logging.INFO)

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)



@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/record', methods=['POST'])
def record():
    user_ip = request.remote_addr
    audio_file = request.files.get('audio')
    logging.info(f'saved record for {audio_file}')
    if audio_file:
        audio_file.save(f'{user_ip}_recording.wav')
        # s3.upload_file(f'{user_ip}_recording.wav', f'asr/{user_ip}_recording.wav')
        return '', 200
    else:
        return 'No audio file found', 400

@app.route('/audio', methods=['GET'])
def get_audio():
    user_ip = request.remote_addr
    return send_file(f'{user_ip}_recording.wav')

@app.route('/test')
def test():
    user_ip = request.remote_addr
    return {'status': f'Welcome user {user_ip}!'}

@app.route('/translate_hf')
def translate_hf():
    user_ip = request.remote_addr
    logging.info(f'translate requested by user_ip={user_ip}')
    # with open(f'{user_ip}_recording.wav', "rb") as f:
        # data = f.read()
    # headers = {"Authorization": f"Bearer {os.getenv('HF_API_KEY')}"}

    # def query_hf(data):
    #     url = "https://api-inference.huggingface.co/models/openai/whisper-tiny.en"
    #     response = requests.post(url, headers=headers, data=data)
    #     result = response.json()
    #     return result
    
    result = {'text': 'Could you write me a 50 word apology for this service being down?'}

    logging.info(f'HF translate result={result}')
    chat_completion = openai.ChatCompletion.create(model="gpt-3.5-turbo", messages=[{"role": "user", "content": result['text']}])

    return {'text': 'Input:\n\n'+ result['text'] + '\n\nOutput:\n\n' + chat_completion.choices[0].message.content}



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
