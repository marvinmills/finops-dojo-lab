terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = local.default_tags
  }
}

locals {
  default_tags = {
    Project       = var.project_name
    Environment   = var.environment
    ManagedBy     = "terraform"
    Assessment    = "100-day-finops-architecture"
    PortfolioRole = "pe-owned-platform"
    CaseStudy     = "case-01-clarionflow-ai"
  }

  accounts = {
    acquired_ai_platform = {
      account_name  = "acquired-ai-platform"
      workload      = "ai-platform"
      business_unit = "acquired-product"
    }
    legacy_core_prod = {
      account_name  = "legacy-core-prod"
      workload      = "core-saas"
      business_unit = "legacy-platform"
    }
    shared_services = {
      account_name  = "shared-services"
      workload      = "shared"
      business_unit = "central-platform"
    }
  }
}