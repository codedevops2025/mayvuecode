#!/bin/bash

VPC_ID="vpc-05e98e048c6f25e87"

# Create db-orcl group
DB_ORCL=$(aws ec2 create-security-group --group-name db-orcl \
  --description "Oracle DB access" --vpc-id $VPC_ID --query 'GroupId' --output text)

aws ec2 authorize-security-group-ingress --group-id $DB_ORCL --protocol tcp --port 1521 --cidr 10.98.0.0/16
aws ec2 authorize-security-group-ingress --group-id $DB_ORCL --protocol tcp --port 1521 --cidr 10.108.0.0/16
aws ec2 authorize-security-group-egress  --group-id $DB_ORCL --protocol -1 --cidr 10.98.0.0/16
aws ec2 authorize-security-group-egress  --group-id $DB_ORCL --protocol -1 --cidr 10.108.0.0/16

# Create rdp group
RDP=$(aws ec2 create-security-group --group-name rdp \
  --description "RDP access" --vpc-id $VPC_ID --query 'GroupId' --output text)

for cidr in 10.98.0.0/16 10.108.0.0/16 0.0.0.0/0; do
  aws ec2 authorize-security-group-ingress --group-id $RDP --protocol tcp --port 3389 --cidr $cidr
done

for cidr in 10.98.0.0/16 10.108.0.0/16; do
  aws ec2 authorize-security-group-ingress --group-id $RDP --protocol tcp --port 22 --cidr $cidr
done

# Create fsx group
FSX=$(aws ec2 create-security-group --group-name fsx \
  --description "FSx access" --vpc-id $VPC_ID --query 'GroupId' --output text)

aws ec2 authorize-security-group-ingress --group-id $FSX --protocol tcp --port 445 --cidr 10.108.0.0/16
aws ec2 authorize-security-group-egress  --group-id $FSX --protocol -1 --cidr 10.108.0.0/16

# Create db-sql group
DB_SQL=$(aws ec2 create-security-group --group-name db-sql \
  --description "SQL Server access" --vpc-id $VPC_ID --query 'GroupId' --output text)

for cidr in 10.98.0.0/16 10.108.0.0/16; do
  aws ec2 authorize-security-group-ingress --group-id $DB_SQL --protocol tcp --port 1433 --cidr $cidr
  aws ec2 authorize-security-group-egress  --group-id $DB_SQL --protocol -1 --cidr $cidr
done

# Create www group
WWW=$(aws ec2 create-security-group --group-name www \
  --description "Public web access" --vpc-id $VPC_ID --query 'GroupId' --output text)

for port in 80 443; do
  aws ec2 authorize-security-group-ingress --group-id $WWW --protocol tcp --port $port --cidr 0.0.0.0/0
done

aws ec2 authorize-security-group-egress --group-id $WWW --protocol -1 --cidr 0.0.0.0/0

# Create www-internal group
WWW_INTERNAL=$(aws ec2 create-security-group --group-name www-internal \
  --description "Internal web access" --vpc-id $VPC_ID --query 'GroupId' --output text)

for port in 80 443; do
  aws ec2 authorize-security-group-ingress --group-id $WWW_INTERNAL --protocol tcp --port $port --cidr 10.108.0.0/16
done

aws ec2 authorize-security-group-egress --group-id $WWW_INTERNAL --protocol -1 --cidr 0.0.0.0/0
