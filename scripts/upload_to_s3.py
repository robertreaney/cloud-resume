import boto3

from typing import Union
from argparse import ArgumentParser
from pathlib import Path
import logging
from time import perf_counter

def main(path:Union[str, Path]='website/static', bucket='reaney-resume'):
    path = Path(path).resolve()
    logging.basicConfig(level=logging.INFO)

    logging.info('connecting to s3 bucket...')
    client = boto3.client('s3')

    files_to_upload = [x for x in path.rglob('*') if x.is_file()]
    n = len(files_to_upload); start = perf_counter()

    for ii, file in enumerate(files_to_upload):
        filename = file.relative_to(Path.cwd()).as_posix()
        key = file.relative_to(path).as_posix()
        logging.info(f'Upload files {ii+1}/{n}. filename={filename} key={key}  elapsed_time={round(perf_counter()-start, 4)}s')
        client.upload_file(filename, 'reaney-resume', key, ExtraArgs={'ContentType':'text/html'})


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('-p', '--path', help='local path to upload', default='website/static')
    parser.add_argument('-b', '--bucket', help='s3 bucket to upload to', default='reaney-resume')
    args = parser.parse_args()

    main(path=args.path, bucket=args.bucket)