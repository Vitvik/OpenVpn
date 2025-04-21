import json
import os
import requests

def lambda_handler(event, context):
    try:
        body = json.loads(event["body"])
        region = body.get("region", "eu-west-1")

        github_token = os.environ.get("GITHUB_TOKEN")
        if not github_token:
            raise ValueError("GITHUB_TOKEN environment variable is not set")

        github_repo = "Vitvik/OpenVpn"
        github_api = f"https://api.github.com/repos/{github_repo}/dispatches"

        headers = {
            "Accept": "application/vnd.github+json",
            "Authorization": f"Bearer {github_token}"
        }

        payload = {
            "event_type": "destroy-vpn",
            "client_payload": {
                "region": region
            }
        }

        response = requests.post(github_api, headers=headers, json=payload)
        
        if response.status_code != 204:  # GitHub API повертає 204 при успіху
            raise Exception(f"GitHub API returned status code {response.status_code}: {response.text}")

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Destroy request sent to GitHub Actions",
                "region": region
            })
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": str(e)
            })
        }