import wave
import contextlib
import ffmpeg

class Audio:
    def convert_webm_to_wav(self, input_path, output_path):
        input_stream = ffmpeg.input(input_path)
        output_stream = ffmpeg.output(input_stream, output_path, format='wav')
        ffmpeg.run(output_stream)

    def record(self, data):
        print(f"Writing audio data of length: {len(data)} bytes to recording.wav")  # Logging data length
        with open('recording.webm', 'wb') as f:
            f.write(data)
        # self.convert_webm_to_wav('recording.webm', 'recording.wav')

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

