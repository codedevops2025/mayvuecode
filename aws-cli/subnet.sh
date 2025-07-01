aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.3.128/26 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-lb-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.16/28 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-db-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.32/28 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-db-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.96/28 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-fs-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.112/28 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-fs-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.128/28 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-fs-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.64/28 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-ad-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.80/28 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-ad-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.255.208/28 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-tgwy-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.255.224/28 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-tgwy-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.255.240/28 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-tgwy-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.0.48/28 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-nat-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.4.0/26 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-apps-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.4.64/26 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-apps-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.4.128/26 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-apps-2c}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.3.0/26 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-lb-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.3.64/26 --availability-zone us-east-2b --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-lb-2b}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.0/28 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-db-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.2.48/28 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-ad-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.0.32/28 --availability-zone us-east-2a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-nat-2a}]'

aws ec2 create-subnet --vpc-id vpc-05e98e048c6f25e87 --cidr-block 10.108.0.64/28 --availability-zone us-east-2c --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-nat-2c}]'
