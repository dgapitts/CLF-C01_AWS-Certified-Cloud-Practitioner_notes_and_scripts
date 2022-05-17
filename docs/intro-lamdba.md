lambda my first function
We created a newFunction under lambda


> https://us-east-1.console.aws.amazon.com/lambda/home?region=us-east-1#/functions/myFunction?newFunction=true&tab=code

```
import json

def lambda_handler(event, context):
    message = 'Hello {} {}! Keep being awesome!'.format(event['first_name'], event['last_name'])  

    #print to CloudWatch logs
    print(message)

    return { 
    'message' : message
    } 
```

To run this we need to pass a JSON event 

> myEvent = { "first_name": "Dave", "last_name": "Pitts" }


Testining this


```
Response
{
  "message": "Hello Dave Pitts! Keep being awesome!"
}
```

And in the cloudwatch logs

```
Function Logs
START RequestId: de1dffc6-1494-4b4e-8fe9-b2d1caef19d0 Version: $LATEST
Hello Dave Pitts! Keep being awesome!
END RequestId: de1dffc6-1494-4b4e-8fe9-b2d1caef19d0
REPORT RequestId: de1dffc6-1494-4b4e-8fe9-b2d1caef19d0	Duration: 0.92 ms	Billed Duration: 1 ms	Memory Size: 128 MB	Max Memory Used: 36 MB

Request ID
de1dffc6-1494-4b4e-8fe9-b2d1caef19d0
```


