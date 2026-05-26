# ----------------------------------------
# SNS topic for budget alerts
# AWS Budgets publishes alerts here, and
# SNS forwards them to the subscribed emails.
# ----------------------------------------

resource "aws_sns_topic" "budget_alerts" {
  name = "${var.project_name}-budget-alerts"
}

# ----------------------------------------
# SNS topic policy for AWS Budgets
# This allows AWS Budgets to publish
# notifications to the SNS topic.
# ----------------------------------------

resource "aws_sns_topic_policy" "budget_alerts_policy" {
  arn = aws_sns_topic.budget_alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAWSBudgetsToPublish"
        Effect = "Allow"
        Principal = {
          Service = "budgets.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.budget_alerts.arn
      }
    ]
  })
}

# ----------------------------------------
# Email subscriptions for budget alerts
# One subscription is created for each
# email listed in var.notification_emails.
# ----------------------------------------

resource "aws_sns_topic_subscription" "email" {
  for_each  = toset(var.notification_emails)
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = each.value
}

# ----------------------------------------
# Monthly cost budgets by logical account
#
# Assumption: my resources will be tagged with
# AccountName = acquired-ai-platform
# AccountName = legacy-core-prod
# AccountName = shared-services
#
# If I don’t tag resources this way, these
# budgets won’t line up with actual costs.
#
# Using the start of 2026 as the budget baseline.
# Monthly budgets reset each month, so this does
# not need to exactly match the dataset timeframe.
# ----------------------------------------

resource "aws_budgets_budget" "monthly_cost_budget" {
  for_each = local.accounts

  name              = "${var.project_name}-${each.value.account_name}-monthly-budget"
  budget_type       = "COST"
  limit_amount      = tostring(var.monthly_budget_limit_usd)
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2026-01-01_00:00"

  cost_filter {
    name   = "TagKeyValue"
    values = ["AccountName$${each.value.account_name}"]
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }

  depends_on = [
    aws_sns_topic_policy.budget_alerts_policy
  ]
}