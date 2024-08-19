import json
import qrcode
import io
import uuid
import boto3

# Initialize S3 and SES clients
s3 = boto3.client('s3')
ses = boto3.client('ses', region_name='us-west-1')

# Replace with your bucket name
bucket_name = 'qr-code-generator-007'

# Replace with your verified sender email
sender_email = 'saitejaroyal3@gmail.com'

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))
    for record in event['Records']:
        body = json.loads(record['body'])
        print("Processing record:", body)
        
        if 'username' in body:
            username = body['username']
            subject = 'Your QR Code for Username'
        else:
            return {
                'statusCode': 400,
                'body': json.dumps('Invalid input data')
            }

        # Generate QR Code
        img = qrcode.make(username)
        buffer = io.BytesIO()
        img.save(buffer)
        buffer.seek(0)  # Rewind the buffer

        # Create a unique filename for the QR code
        key = f'qrcodes/{username}-{uuid.uuid4()}.png'

        # Upload the QR code image to S3
        s3.put_object(
            Bucket=bucket_name,
            Key=key,
            Body=buffer,
            ContentType='image/png'
        )

        # Create a pre-signed URL for the QR code
        qr_code_url = s3.generate_presigned_url(
            'get_object',
            Params={'Bucket': bucket_name, 'Key': key},
            ExpiresIn=3600  # URL expiration time in seconds
        )

        # Send an email with the QR code URL
        response = ses.send_email(
            Source=sender_email,
            Destination={'ToAddresses': ['200303126124@paruluniversity.ac.in']},
            Message={
                'Subject': {'Data': subject},
                'Body': {
                    'Html': {
                        'Data': f"<h1>Here is your QR Code</h1><p><a href='{qr_code_url}'>Click here to view your QR code</a></p>"
                    }
                }
            }
        )
        print("Email sent successfully, response:", response)
    
    return {
        'statusCode': 200,
        'body': json.dumps('QR Code generated and email sent successfully')
    }
