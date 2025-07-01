# Required Inputs
You must define two Terraform variables before using this code:
  - vpc_cidr
  - vpc_id
vpc_cidr must be either /16 or /22 — the logic adapts accordingly.
vpc_id must match the actual VPC ID in your AWS account

# Subnets creation
The script calculates 21 subnets (3 AZs × 7 roles).
All subnet CIDRs are dynamically generated from vpc_cidr.
Subnets are tagged using a consistent naming convention, like:
    public-lb-2a, private-apps-2b, etc.

# If a Subnet Already Exists
You have two options:
  - Import it into Terraform first:
   terraform import aws_subnet.generated["public-lb-2a"] subnet-0123456789abcdef0
  - Comment it out from the Terraform tfvars list 