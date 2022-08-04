import json
import urllib
from datetime import datetime
import boto3

def lambda_handler(event, context):
       
       now = datetime.now()
       datestring = now.strftime('%Y-%m-%d_%H-%M-%S')
       s3 = boto3.resource('s3')
       # BucketName = os.environ['BucketName']
       BucketName = "divvy-data-rstuart"

       freebikes_url = "https://gbfs.divvybikes.com/gbfs/es/free_bike_status.json"
       station_url = "https://gbfs.divvybikes.com/gbfs/en/station_status.json"
       
       # Get Station Info and write to S3
       print("pull station info")
       req = urllib.request.Request(station_url)
       response = urllib.request.urlopen(req)
       data = response.read()
       values = json.loads(data)
       file_name = f"station_status-{datestring}.json"
       s3_file_path = f"station_status/{file_name}"
       obj = s3.Object(BucketName,s3_file_path) 
       obj.put(Body=json.dumps(values))

       # Get Ebike not docked Info and write to S3
       print("pull free ebike data")
       req = urllib.request.Request(freebikes_url)
       response = urllib.request.urlopen(req)
       data = response.read()
       values = json.loads(data)
       file_name = f"free_bike_status-{datestring}.json"
       s3_file_path = f"free_bike_status/{file_name}"
       obj = s3.Object(BucketName,s3_file_path) 
       obj.put(Body=json.dumps(values))
