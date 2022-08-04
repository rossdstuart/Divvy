import json
import urllib
from datetime import datetime
import boto3

def lambda_handler(event, context):
       
       now = datetime.now()
       datestring = now.strftime('%Y-%m-%d_%H-%M-%S')
       s3 = boto3.resource('s3')
       BucketName = "divvy-data-rstuart"
       weather_url = ""


       #Get Weather in Chicago
       print("pull weather data")
       req = urllib.request.Request(weather_url)
       response = urllib.request.urlopen(req)
       data = response.read()
       values = json.loads(data)
       file_name = f"weather-{datestring}.json"
       s3_file_path = f"weather/{file_name}"
       obj = s3.Object(BucketName,s3_file_path) 
       obj.put(Body=json.dumps(values))
       print("done")