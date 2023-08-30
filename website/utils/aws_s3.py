import boto3

class AWSS3:
    def __init__(self):
        self.s3 = boto3.client('s3')

    def upload_file(self, file_name, object_name):
        self.s3.upload_file(file_name, 'reaney-data-lake', object_name)

    def download_file(self, object_name, file_name):
        self.s3.download_file('reaney-data-lake', object_name, file_name)
