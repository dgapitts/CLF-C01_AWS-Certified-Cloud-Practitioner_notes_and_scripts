## Intro to aws cli to start and stop ec2 nodes 

### Scripts





```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ head aws-ec2-describe-instance-*
==> aws-ec2-describe-instance-start.sh <==
## https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
## Pre state
echo "Pre state (all instances)"
echo -e 'InstanceId\t\tState&code\tTag'
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, State.code, tag.name]" --o text
## Stopping
echo "Startingg " $1
aws ec2 start-instances --instance-ids $1
## Post state
echo "Post state (all instances)"

==> aws-ec2-describe-instance-state.sh <==
## https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
echo -e 'InstanceId\t\tState&code\tTag'
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, State.code, tag.name]" --o text

==> aws-ec2-describe-instance-stop.sh <==
## https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
## Pre state
echo "Pre state (all instances)"
echo -e 'InstanceId\t\tState&code\tTag'
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, State.code, tag.name]" --o text
## Stopping
echo "Stopping " $1
aws ec2 stop-instances --instance-ids $1
## Post state
echo "Post state (all instances)"
```

### Demo start 
During the start operation and now I had the for-loop checking status every 10secs
* initially the state goes from stopping to pending
* after a while state becomes stopped

```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts/docs $ ./aws-ec2-describe-instance-start.sh i-0f4b5b1ab299e960e
Pre state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopped	None	None
Startingg  i-0f4b5b1ab299e960e
{
    "StartingInstances": [
        {
            "InstanceId": "i-0f4b5b1ab299e960e",
            "CurrentState": {
                "Code": 0,
                "Name": "pending"
            },
            "PreviousState": {
                "Code": 80,
                "Name": "stopped"
            }
        }
    ]
}
Post state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	pending	None	None
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts/docs $ ./aws-ec2-describe-instance-state.sh
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	running	None	None
^C
```

### Demo stop 

similarly for the stop operation and now I had the for-loop checking status every 10secs
* initially the state goes from running to stopping
* after about 20secs to 30secs the state becomes stopped

```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts/docs $ ./aws-ec2-describe-instance-stop.sh i-0f4b5b1ab299e960e
Pre state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	running	None	None
Stopping  i-0f4b5b1ab299e960e
{
    "StoppingInstances": [
        {
            "InstanceId": "i-0f4b5b1ab299e960e",
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
Post state (all instances)
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopping	None	None
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts/docs $ for i in {1..10};do ./aws-ec2-describe-instance-state.sh;sleep 10;done
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopping	None	None
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopping	None	None
InstanceId		State&code	Tag
i-0f4b5b1ab299e960e	stopped	None	None
^C
```
