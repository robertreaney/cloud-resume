from flask import Flask, request, send_file, jsonify
import logging
import os
import whisper
import openai
from werkzeug.middleware.proxy_fix import ProxyFix

# overhead
app = Flask(__name__)
logging.basicConfig(level=logging.INFO)
app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)

# model
model_name = os.getenv("ASR_MODEL", "base")
model = whisper.load_model(model_name)

# API
@app.route('/asr', methods=['POST'])
def asr():
    audio_file = request.files.get('audio')
    result = model.transcribe(audio_file)
    return {'text': result['text']}

@app.route('/smoke', methods=['GET'])
def smoke():
    result = model.transcribe('recording.wav')
    chat_completion = openai.ChatCompletion.create(model="gpt-3.5-turbo", messages=[{"role": "user", "content": result['text']}])

    # return {'text': result['text']}
    return {'text': 'Input:\n\n'+ result['text'] + '\n\nOutput:\n\n' + chat_completion.choices[0].message.content}

@app.route('/test')
def test():
    return {'status': 'asr working!'}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)
