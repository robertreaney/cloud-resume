from flask import Flask, request, send_file
from aws_s3 import AWSS3
from audio import Audio
import logging

app = Flask(__name__)
s3 = AWSS3()
audio = Audio()
logging.basicConfig(level=logging.INFO)

@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/record', methods=['POST'])
def record():
    audio_file = request.files.get('audio')
    logging.info(f'saved record for {audio_file}')
    if audio_file:
        audio_file.save('recording.wav')
        s3.upload_file('recording.wav', 'asr/recording.wav')
        return '', 200
    else:
        return 'No audio file found', 400

@app.route('/playback', methods=['GET'])
def playback():
    logging.info('playing back audio file.')
    s3.download_file('asr/recording.wav', 'recording.wav')
    length = audio.get_length('recording.wav')
    return {'length': length}, 200

@app.route('/audio', methods=['GET'])
def get_audio():
    return send_file('recording.wav')

if __name__ == '__main__':
    app.run(debug=True)
