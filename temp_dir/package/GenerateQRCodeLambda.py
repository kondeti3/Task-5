import json
import boto3
import qrcode
import io
import base64

ses = boto3.client('ses')

def lambda_handler(event, context):
    for record in event['Records']:
        body = json.loads(record['body'])
        
        if 'username' in body:
            identifier = body['username']
            subject = 'Your QR Code for Username'
        elif 'phoneNumber' in body:
            identifier = body['phoneNumber']
            subject = 'Your QR Code for Phone Number'
        else:
            return {
                'statusCode': 400,
                'body': json.dumps('Invalid input data')
            }

        # Generate QR Code
        img = qrcode.make(identifier)
        buffer = io.BytesIO()
        img.save(buffer, format="PNG")
        qr_code_str = base64.b64encode(buffer.getvalue()).decode()

        # Send Email
        ses.send_email(
            Source='your-email@example.com',
            Destination={'ToAddresses': ['recipient@example.com']},
            Message={
                'Subject': {'Data': subject},
                'Body': {
                    'Html': {
                        'Data': f"<h1>Here is your QR Code</h1><img src='data:image/png;base64,{qr_code_str}'/>"
                    }
                }
            }
        )
    
    return {
        'statusCode': 200,
        'body': json.dumps('QR Code sent successfully')
    }
