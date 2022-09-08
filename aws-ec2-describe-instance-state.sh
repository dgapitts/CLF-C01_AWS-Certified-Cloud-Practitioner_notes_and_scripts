## https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
date
echo -e 'InstanceId\t\tState&code\tTag'
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, State.code, tag.name]" --o text 
