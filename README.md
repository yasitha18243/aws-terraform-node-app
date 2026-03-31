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
- Remote Terraform state in S3 + DynamoDB locking

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
├── app/                          # Node.js sample app
│   ├── server.js
│   └── package.json
└── terraform/            
    ├── modules/
    │   ├── vpc/                  # VPC, subnets, IGW
    │   ├── ec2/                  # EC2, ALB, IAM, security groups
    │   └── s3/                   # App code bucket
├── docs/                         # Architecture Diagram
```
## Prerequisites

- AWS account with IAM user + access keys
- Terraform >= 1.0 installed
- AWS CLI configured (`aws configure`)
- Node.js 18+ (for local app testing)

## Quick Start

### 1. Clone the repo
```bash
git clone https://github.com/yasitha18243/aws-terraform-node-app.git
cd aws-terraform-node-app
```


