import os
import sys
import boto3
from botocore.handlers import disable_signing

INPUTS  = sys.argv[1]
OUT     = sys.argv[2]

with open(INPUTS, "r") as f:
    inputs = [l.strip() for l in f]

I = inputs

BUCKET_NAME = "1000genomes"
DIR = "{bucket}/phase3/data/{idx}/sequence_read/"
KEY_F = "phase3/data/{idx}/sequence_read/{file}"

s3 = boto3.resource("s3")
s3.meta.client.meta.events.register("choose-signer.s3.*", disable_signing)
bucket = s3.Bucket(BUCKET_NAME)

for dataset in I:
    IDX, LIST_DL, OUTPUT = dataset.split(' ')
    OUT_DIR = f"{OUT}/{OUTPUT}/{IDX}"
    os.makedirs(OUT_DIR, exist_ok=True)
    with open(LIST_DL, 'r') as f:
        for line in f:
            filename = line.strip()
            output = f"{OUT_DIR}/{filename}"
            key = KEY_F.format(idx=IDX, file=filename)
            print(key, output)
            bucket.download_file(key, output)

