# ClarionFlow AI Terraform Baseline

This Terraform pack provisions a lightweight baseline AWS environment for the ClarionFlow AI case. It is designed to support a synthetic post-acquisition FinOps assessment across three logical cost centers: `acquired-ai-platform`, `legacy-core-prod`, and `shared-services`.


## Files
- `main.tf` — provider, shared locals, logical account context
- `variables.tf` — shared inputs
- `network.tf` — VPC, subnets, internet gateway, NAT gateway
- `compute.tf` — ECS/Fargate, EC2, and Lambda scaffolding
- `data.tf` — S3, Glue, and RDS resources for data and analysis support
- `observability.tf` — starter CloudWatch dashboard
- `budgets.tf` — budgets and SNS-based alerts
- `outputs.tf` — key outputs for workflow handoff
- `scripts/upload_data.py` — helper script for loading synthetic data into S3



## Recommended Workflow
1. Run `terraform init`
2. Run `terraform plan`
3. Run `terraform apply`
4. Capture the `s3_data_bucket` output
5. Upload synthetic billing / usage data to the bucket with `scripts/upload_data.py`
6. Start your initial analysis in Jupyter or SQL