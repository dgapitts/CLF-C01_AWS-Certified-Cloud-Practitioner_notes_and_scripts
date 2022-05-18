## Lab02 - Intro to VPC with a Publis Subnet plus Route Table with an Internet Gateway and an EC2 instance


Here is a summary of what I configured (under my personal AWS sandbox account)

Note: the Route Table, has an associated internet gateway (to the whole internet 0.0.0.0/0) and this Route Table is then associated with our "Public Subnet"

### VPC

* IPv4 CIDR - 10.0.0.0/16
* IP6 - none
* Tag - sb20220516

### Public Subnet

* IPv4 CIDR - 10.0.0.0/24
* Route Table - rtb-0d56db7c99397a4b3

### Route Table

* Tag - sb20220516
* Id rtb-0d56db7c99397a4b3
* Routes
```
Destination     Target                   Status   Propagated
10.0.0.0/16     local	                 Active	  No
0.0.0.0/0       igw-00b10adff9a555c0f	 Active   No
```

### Internet Gateway

* ID - igw-00b10adff9a555c0f
* Tag - sb20220516


