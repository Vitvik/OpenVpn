import boto3
import os
import base64
import json

s3 = boto3.client('s3')

def lambda_handler(event, context):
    print("DEBUG: Lambda started")
    print("Incoming event:", json.dumps(event))

    username = event.get('queryStringParameters', {}).get('username')
    print("Query string params:", username)

    if not username:
        return {
            'statusCode': 400,
            'body': 'Missing username'
        }

    bucket_name = os.environ['S3_BUCKET_NAME']
    key = f"{username}.ovpn"

    print(f"Fetching file {key} from bucket {bucket_name}")

    try:
        obj = s3.get_object(Bucket=bucket_name, Key=key)
        content = obj['Body'].read()
        print("File fetched successfully, encoding...")

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/octet-stream",
                "Content-Disposition": f'attachment; filename="{username}.ovpn"',
                "Access-Control-Allow-Origin": "*"
            },
            "body": base64.b64encode(content).decode("utf-8"),
            "isBase64Encoded": True
        }


    except Exception as e:
        print("ERROR:", str(e))
        return {
            'statusCode': 500,
            'body': f"Error: {str(e)}"
        }