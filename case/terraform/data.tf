resource "aws_s3_bucket" "finops_data" {
  bucket = "${var.project_name}-finops-data"
}

resource "aws_db_instance" "app_db" {
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "15"
  instance_class      = "db.t3.micro"
  db_name             = "clarionflow"
  username            = var.db_username
  password            = random_password.db_password.result
  skip_final_snapshot = true
  multi_az            = false

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = merge(local.default_tags, {
    Name         = "${var.project_name}-rds-app-db"
    AccountName  = local.accounts.acquired_ai_platform.account_name
    Workload     = local.accounts.acquired_ai_platform.workload
    BusinessUnit = local.accounts.acquired_ai_platform.business_unit
  })
}

resource "aws_glue_catalog_database" "finops" {
  name = "${var.project_name}-finops"
}



resource "random_password" "db_password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${var.project_name}/rds/master-credentials"

  tags = merge(local.default_tags, {
    Name         = "${var.project_name}-db-credentials"
    AccountName  = local.accounts.acquired_ai_platform.account_name
    Workload     = local.accounts.acquired_ai_platform.workload
    BusinessUnit = local.accounts.acquired_ai_platform.business_unit
  })
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id

  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    db_name  = "clarionflow"
  })
}