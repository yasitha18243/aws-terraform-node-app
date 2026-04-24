# prod/backend.hcl
bucket       = "node-app-terraform-state-2026"
key          = "prod/terraform.tfstate"
region       = "ap-southeast-2"
use_lockfile = true