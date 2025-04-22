import boto3
import json
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    try:
        # Додаємо логування для дебагу
        print("Event:", json.dumps(event))
        
        # Отримуємо параметри з query string
        query_params = event.get('queryStringParameters', {})
        print("Query params:", query_params)
        
        username = query_params.get('username')
        print("Username:", username)
        
        if not username:
            return {
                'statusCode': 400,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({'error': 'Username parameter is required'})
            }
        
        # Отримуємо файл з S3
        bucket_name = os.environ['S3_BUCKET_NAME']
        print("Bucket name:", bucket_name)
        
        response = s3.get_object(
            Bucket=bucket_name,
            Key=f"{username}.ovpn"
        )
        
        # Повертаємо файл
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/x-openvpn-profile',
                'Content-Disposition': f'attachment; filename="{username}.ovpn"'
            },
            'body': response['Body'].read().decode('utf-8'),
            'isBase64Encoded': False
        }
        
    except Exception as e:
        print("Error:", str(e))
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': str(e)})
        }