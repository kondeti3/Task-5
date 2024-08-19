import json
import boto3

eventbridge = boto3.client('events')

def lambda_handler(event, context):
    # If event has 'body', it's likely from API Gateway
    if 'body' in event:
        body = json.loads(event['body'])
    else:
        # If no 'body', assume event is directly the data
        body = event
    
    if 'username' in body and 'phoneNumber' in body:
        return {
            'statusCode': 400,
            'body': json.dumps('Please provide either username or phoneNumber, but not both')
        }
    
    if 'username' in body:
        detail = {'username': body['username']}
        event_source = 'com.qrcode.username'
    elif 'phoneNumber' in body:
        detail = {'phoneNumber': body['phoneNumber']}
        event_source = 'com.qrcode.phoneNumber'
    else:
        return {
            'statusCode': 400,
            'body': json.dumps('Invalid input data')
        }

    eventbridge.put_events(
        Entries=[
            {
                'Source': event_source,
                'DetailType': 'QRCodeGeneration',
                'Detail': json.dumps(detail),
                'EventBusName': 'NewQRCodeEventBus'
            }
        ]
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('QR Code generation request submitted successfully')
    }
