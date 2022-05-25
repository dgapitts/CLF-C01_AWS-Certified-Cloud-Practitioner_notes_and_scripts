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
echo -e 'InstanceId\t\tState&code\tTag'
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, State.code, tag.name]" --o text 
