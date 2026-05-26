output "finops_data_bucket_name" {
  description = "S3 bucket for ClarionFlow FinOps data"
  value       = aws_s3_bucket.finops_data.bucket
}

output "rds_endpoint" {
  description = "Endpoint for ClarionFlow app database"
  value       = aws_db_instance.app_db.address
}