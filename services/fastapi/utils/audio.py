import wave
# import pyaudio

class Audio:
    def record(self, data):
        print(f"Writing audio data of length: {len(data)} bytes to recording.wav")  # Logging data length
        with open('recording.wav', 'wb') as f:
            f.write(data)

    def get_length(self, file_name):
        try:
            with wave.open(file_name, 'r') as f:
                frames = f.getnframes()
                rate = f.getframerate()
                length = frames / float(rate)
                return length
        except wave.Error as e:
            print(f"Wave Error: {e}")
            return -1
        except Exception as e:
            print(f"Other Error: {e}")
            return -1
        
    # def playback(self, file_name):


