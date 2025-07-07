# 1. create vpc
# 2. create subnets
# 3. create infra (eip, igw,nat)
# 4. create routes & route associations
# 5. create virtual private gateway ---> to be added in the code
# 6. create security groups
# 7. create ec2 instance
# 8. execute script inside the ec2 instance
Open Notepad or any text editor
Paste the full script package-install.ps1
save it as script package-install.ps1
Open PowerShell as Administrator
Set Execution Policy (if needed)
```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
```

   option group
   subnet group
   iam role
   