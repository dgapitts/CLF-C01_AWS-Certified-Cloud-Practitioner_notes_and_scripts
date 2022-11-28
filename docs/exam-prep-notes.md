# exam-prep-notes

## Macie - security inventory for s3 

https://docs.aws.amazon.com/macie/latest/user/what-is-macie.html

> Macie automates the discovery of sensitive data, such as personally identifiable information (PII) and financial data, to provide you with a better understanding of the data that your organization stores in Amazon Simple Storage Service (Amazon S3). Macie also provides you with an inventory of your S3 buckets, and it automatically evaluates and monitors those buckets for security and access control. Within minutes, Macie can identify and report overly permissive or unencrypted buckets for your organization.




##  Trusted Advisor Recommendations - Cost - Perf - Security - Fault Tolerence - Service Limits

https://docs.aws.amazon.com/awssupport/latest/user/get-started-with-aws-trusted-advisor.html

> You can view the check descriptions and results for the following check categories:
* Cost optimization – Recommendations that can potentially save you money. These checks highlight unused resources and opportunities to reduce your bill.
* Performance – Recommendations that can improve the speed and responsiveness of your applications.
* Security – Recommendations for security settings that can make your AWS solution more secure.
* Fault tolerance – Recommendations that help increase the resiliency of your AWS solution. These checks highlight redundancy shortfalls, current service limits (also known as quotas), and overused resources.
* Service limits – Checks the usage for your account and whether your account approaches or exceeds the limit (also known as quotas) for AWS services and resources.

To view check categories: Sign in to the Trusted Advisor console at https://console.aws.amazon.com/trustedadvisor/home.



## AWS Pillars

> Operational Excellence Pillar

The operational excellence pillar focuses on running and monitoring systems, and continually improving processes and procedures. Key topics include automating changes, responding to events, and defining standards to manage daily operations.


> Security Pillar

The security pillar focuses on protecting information and systems. Key topics include confidentiality and integrity of data, managing user permissions, and establishing controls to detect security events.

> Reliability Pillar

The reliability pillar focuses on workloads performing their intended functions and how to recover quickly from failure to meet demands. Key topics include distributed system design, recovery planning, and adapting to changing requirements.

> Performance Efficiency Pillar

The performance efficiency pillar focuses on structured and streamlined allocation of IT and computing resources. Key topics include selecting resource types and sizes optimized for workload requirements, monitoring performance, and maintaining efficiency as business needs evolve.

> Cost Optimization Pillar

The cost optimization pillar focuses on avoiding unnecessary costs. Key topics include understanding spending over time and controlling fund allocation, selecting resources of the right type and quantity, and scaling to meet business needs without overspending.

> Sustainability Pillar

The sustainability pillar focuses on minimizing the environmental impacts of running cloud workloads. Key topics include a shared responsibility model for sustainability, understanding impact, and maximizing utilization to minimize required resources and reduce downstream impacts. 


###  What is AWS Shield?

> AWS Shield is a managed service that provides protection against Distributed Denial of Service (DDoS) attacks for applications running on AWS. AWS Shield Standard is automatically enabled to all AWS customers at no additional cost. AWS Shield Advanced is an optional paid service. AWS Shield Advanced provides additional protections against more sophisticated and larger attacks for your applications running on Amazon Elastic Compute Cloud (EC2), Elastic Load Balancing (ELB), Amazon CloudFront, AWS Global Accelerator, and Route 53.https://aws.amazon.com/shield/faqs/



### What is AWS Shield Standard?
AWS Shield Standard provides protection for all AWS customers against common and most frequently occurring infrastructure (layer 3 and 4) attacks like SYN/UDP floods, reflection attacks, and others to support high availability of your applications on AWS. https://aws.amazon.com/shield/faqs/






##  AWS Well-Architected Tool

> Q: What is the AWS Well-Architected Tool?

The AWS Well-Architected Tool lets you review your workloads against current AWS best practices and obtain advice on how to architect your workloads for the cloud. This tool uses the AWS Well-Architected Framework.

> Q: What are the pillars of the AWS Well-Architected Framework?

The general design principles and specific AWS best practices and guidance are organized into six conceptual areas. These conceptual areas are the pillars of the AWS Well-Architected Framework. These six pillars are operational excellence, security, reliability, performance efficiency, cost optimization, and sustainability.

https://aws.amazon.com/well-architected-tool/faqs/



## Service Control Policies

> (SCPs)—An SCP defines the AWS service actions, such as Amazon EC2 RunInstances, that are available for use in different accounts within an organization. https://aws.amazon.com/organizations/faqs/

### SCP example for DenyAllOutsideEU

> This SCP denies access to any operations outside of the specified Regions.
https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples_general.html
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAllOutsideEU",
            "Effect": "Deny",
            "NotAction": [
                "a4b:*",
                "acm:*",
                "aws-marketplace-management:*",
                "aws-marketplace:*",
                "aws-portal:*",
                "budgets:*",
                "ce:*",
                "chime:*",
                "cloudfront:*",
                "config:*",
                "cur:*",
                "directconnect:*",
                "ec2:DescribeRegions",
                "ec2:DescribeTransitGateways",
                "ec2:DescribeVpnGateways",
                "fms:*",
                "globalaccelerator:*",
                "health:*",
                "iam:*",
                "importexport:*",
                "kms:*",
                "mobileanalytics:*",
                "networkmanager:*",
                "organizations:*",
                "pricing:*",
                "route53:*",
                "route53domains:*",
                "s3:GetAccountPublic*",
                "s3:ListAllMyBuckets",
                "s3:PutAccountPublic*",
                "shield:*",
                "sts:*",
                "support:*",
                "trustedadvisor:*",
                "waf-regional:*",
                "waf:*",
                "wafv2:*",
                "wellarchitected:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "eu-central-1",
                        "eu-west-1"
                    ]
                },
                "ArnNotLike": {
                    "aws:PrincipalARN": [
                        "arn:aws:iam::*:role/Role1AllowedToBypassThisSCP",
                        "arn:aws:iam::*:role/Role2AllowedToBypassThisSCP"
                    ]
                }
            }
        }
    ]
}
```