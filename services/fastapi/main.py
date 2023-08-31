from fastapi import FastAPI, File, UploadFile
from fastapi.staticfiles import StaticFiles
import logging

from utils.aws_s3 import AWSS3
from utils.audio import Audio

app = FastAPI()
s3 = AWSS3()
audio = Audio()
logging.basicConfig(level=logging.DEBUG)

# mount front-end
app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/")
async def root():
    return {"message": "Test"}

# @app.get("/playback")
# async def playback():
#     logging.debug('playing back audio file.')
#     s3.download_file('asr/recording.wav', 'recording.wav')
#     length = audio.get_length('recording.wav')
#     return {'length': length}

# @app.post('/record')
# def record():
#     audio_file = request.files.get('audio')
#     logging.info(f'saved record for {audio_file}')
#     if audio_file:
#         audio_file.save('recording.wav')
#         s3.upload_file('recording.wav', 'asr/recording.wav')
#         return '', 200
#     else:
#         return 'No audio file found', 400

@app.get("/test/{_id}")
async def read_item(_id: int):
    return {"id": _id}