import boto3

print('connecting to s3 bucket...')
client = boto3.client('s3')

print('updating index.html...')
response = client.upload_file('website/index.html', 'reaney-resume', 'index.html',ExtraArgs={'ContentType':'text/html'})