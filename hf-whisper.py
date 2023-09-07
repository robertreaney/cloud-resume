token = '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'
import requests

API_URL = "https://api-inference.huggingface.co/models/openai/whisper-tiny.en"
headers = {"Authorization": f"Bearer {token}"}

def query(filename):
    with open(filename, "rb") as f:
        data = f.read()
    response = requests.post(API_URL, headers=headers, data=data)
    return response.json()


output = query("services/asr/recording.wav")
output