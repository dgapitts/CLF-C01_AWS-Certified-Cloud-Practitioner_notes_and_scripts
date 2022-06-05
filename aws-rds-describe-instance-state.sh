## https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
## https://docs.aws.amazon.com/cli/latest/reference/rds/describe-db-clusters.html

echo "aws rds  describe-db-clusters - all details"
aws rds  describe-db-clusters

echo -e 'InstanceId\t\tState&code\tTag'
aws rds  describe-db-clusters --query 'DBClusters[].{DBClusterIdentifier:DBClusterIdentifier,Endpoint:Endpoint,ReaderEndpoint:ReaderEndpoint}' --o text 
