# ----------------------------------------
# CloudWatch dashboard scaffold
# Starting with a simple dashboard so the
# observability layer exists in v1.
# I can add cost, usage, and service widgets
# after the core resources are in place.
# ----------------------------------------





resource "aws_cloudwatch_dashboard" "finops_overview" {
  dashboard_name = "${var.project_name}-finops-overview"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text",
        x      = 0,
        y      = 0,
        width  = 24,
        height = 4,
        properties = {
          markdown = "# ClarionFlow AI FinOps Overview"
        }
      }
    ]
  })
}