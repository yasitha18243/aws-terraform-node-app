# AWS Cloud Platform — Terraform Project

A production-ready AWS infrastructure built for a simple Node.js app with
Terraform, demonstrating cloud/platform engineering
best practices.

## Architecture

![Architecture Diagram](docs/architecture.png)

## What This Project Builds

- VPC with public and private subnets across 2 AZs
- Application Load Balancer - Public Facing
- 2x EC2 t3.micro instances - In Private Subnets
- S3 bucket for app code storage
- IAM roles with least privilege
- Remote Terraform state in S3 with native state locking
- Isolated environments — dev, staging, prod

## Tech Stack

| Tool        | Purpose                        |
|-------------|--------------------------------|
| Terraform   | Infrastructure as Code         |
| AWS VPC     | Network isolation              |
| AWS EC2     | Application compute            |
| AWS ALB     | Load balancing + health checks |
| AWS S3      | App code + Terraform state     |
| AWS IAM     | Least privilege access control |
| Node.js     | Sample application             |

## Project Structure
```
aws-terraform-node-app/
├── app/                                # Node.js sample app
│   ├── server.js
│   └── package.json
├── terraform/
│   ├── main.tf                         # Shared — module calls
│   ├── variables.tf                    # Shared — input declarations
│   ├── outputs.tf                      # Shared — output values
│   ├── modules/
│   │   ├── vpc/                        # VPC, subnets, IGW
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── ec2/                        # EC2, ALB, IAM, security groups
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── s3/                         # App code bucket
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── environments/
│       ├── dev/
│       │   ├── backend.hcl             # Dev state config
│       │   ├── terraform.tfvars        # Dev values (gitignored)
│       │   └── terraform.tfvars.example
│       ├── staging/
│       │   ├── backend.hcl             # Staging state config
│       │   ├── terraform.tfvars        # Staging values (gitignored)
│       │   └── terraform.tfvars.example
│       └── prod/
│           ├── backend.hcl             # Prod state config
│           ├── terraform.tfvars        # Prod values (gitignored)
│           └── terraform.tfvars.example
└── docs/                               # Architecture Diagram
```

## Environment Isolation

Each environment is fully isolated with its own:
- Terraform state file in S3
- VPC and CIDR block
- EC2 instance size
- Named AWS resources

| | Dev | Staging | Prod |
|---|---|---|---|
| Instance | t3.micro | t3.small | t3.large |
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 | 10.2.0.0/16 |
| State Key | dev/terraform.tfstate | staging/terraform.tfstate | prod/terraform.tfstate |

## Prerequisites
- AWS account with IAM user + access keys
- Terraform >= 1.10 installed
- AWS CLI configured (`aws configure`)
- Node.js 18+ (for local app testing)

## Quick Start

### 1. Clone the repo
```bash
git clone https://github.com/yasitha18243/aws-terraform-node-app.git
cd aws-terraform-node-app
```
### 2. Create Terraform State Storage
```bash
# Create S3 bucket for Terraform state
aws s3 mb s3://node-app-terraform-state-2026 --region ap-southeast-2

# Enable versioning
aws s3api put-bucket-versioning `
  --bucket node-app-terraform-state-2026 `
  --versioning-configuration Status=Enabled

> No DynamoDB needed — this project uses Terraform 1.10+ native S3 state locking via `use_lockfile = true`
```
### 3. Set Up Environment Variables
```powershell
# Copy example vars and fill in your values
cp environments/dev/terraform.tfvars.example environments/dev/terraform.tfvars
cp environments/staging/terraform.tfvars.example environments/staging/terraform.tfvars
cp environments/prod/terraform.tfvars.example environments/prod/terraform.tfvars
```
### 4. Deploy Dev
```powershell
cd terraform
terraform init -backend-config="environments/dev/backend.hcl"
terraform plan -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### 5. Deploy Staging
```powershell
terraform init -backend-config="environments/staging/backend.hcl" -reconfigure
terraform plan -var-file="environments/staging/terraform.tfvars"
terraform apply -var-file="environments/staging/terraform.tfvars"
```

### 6. Deploy Prod
```powershell
terraform init -backend-config="environments/prod/backend.hcl" -reconfigure
terraform plan -var-file="environments/prod/terraform.tfvars"
terraform apply -var-file="environments/prod/terraform.tfvars"
```
### 7. Test the App
```powershell
# Get ALB URL
terraform output alb_dns_name

# Test endpoints
curl http://<alb_dns_name>/health
curl http://<alb_dns_name>/games
```
### 8. Destroy an Environment When Done
```powershell
# Only destroys the targeted environment — others are untouched
terraform init -backend-config="environments/dev/backend.hcl" -reconfigure
terraform destroy -var-file="environments/dev/terraform.tfvars"
```
## Security Highlights

- EC2 instances are in **private subnets** — not directly
  accessible from the internet
- ALB is the **only public entry point**
- IAM roles use **least privilege** — EC2 can only
  read from its own S3 bucket
- Public access is blocked from the S3 bucket
- No hardcoded credentials anywhere in code
- Terraform state encrypted at rest in S3
- `terraform.tfvars` is gitignored — sensitive values never pushed to GitHub

## Estimated AWS Cost

| Resource      | Cost                        |
|---------------|-----------------------------|
| EC2 x2        | Free tier (t3.micro)        |
| ALB           | $0.025/hr (~$18/month)      |
| S3            | < $1/month                  |
| **Total**     | **~$0 with free tier**      |

> Always run `terraform destroy` when not in use

## Author

Yasitha Herath — [LinkedIn](https://www.linkedin.com/in/yasitha18243)
  | [GitHub](https://github.com/yasitha18243)

