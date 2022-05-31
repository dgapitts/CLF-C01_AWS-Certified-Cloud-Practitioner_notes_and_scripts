## Adding `aws rds`  permissions to my default cli user

I was hitting this `not authorized` error:
```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ aws rds describe-db-clusters

An error occurred (AccessDenied) when calling the DescribeDBClusters operation: User: arn:aws:iam::827589484650:user/ec2-base-admin is not authorized to perform: rds:DescribeDBClusters on resource: arn:aws:rds:us-east-1:827589484650:cluster:* because no identity-based policy allows the rds:DescribeDBClusters action
```



In IAM Policies attach `AmazonRDSFullAccess` to `user/ec2-base-admin` (my default cli user)

> Policy ARN: arn:aws:iam::aws:policy/AmazonRDSFullAccess 
Description: Provides full access to Amazon RDS via the AWS Management Console.

Now I can query rds details
```
~/projects/CLF-C01_AWS-Certified-Cloud-Practitioner_notes_and_scripts $ aws rds describe-db-clusters
{
    "DBClusters": []
}
```
