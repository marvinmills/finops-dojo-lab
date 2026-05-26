variable "aws_region" {
  description = "AWS region for the inherited ClarionFlow AI baseline environment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Top-level environment label"
  type        = string
  default     = "post-acquisition"
}

variable "project_name" {
  description = "Project identifier for shared tagging"
  type        = string
  default     = "clarionflow-ai"
}

variable "notification_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
  default = [
    "z3@fastmail.com"
  ]
}

variable "monthly_budget_limit_usd" {
  description = "Default monthly budget limit applied to each logical account budget"
  type        = number
  default     = 100
}

variable "aws_profile" {
  description = "Named AWS CLI profile for this FinOps dojo environment"
  type        = string
  default     = "finops-dojo"
}

variable "db_username" {
  description = "Master username for the ClarionFlow PostgreSQL instance"
  type        = string
  default     = "appuser"
  sensitive   = true
}