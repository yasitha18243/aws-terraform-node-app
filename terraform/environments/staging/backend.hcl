# staging/backend.hcl
bucket       = "node-app-terraform-state-2026"
key          = "staging/terraform.tfstate"
region       = "ap-southeast-2"
use_lockfile = true