
variable "vpc_security_group_id" {
  description = "VPC Security Group ID for the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "DB Subnet Group Name"
  type        = string
}

resource "aws_db_instance" "db_rds_foodtech" {
  identifier                  = "rds-foodtech"
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "postgres"
  engine_version              = "11.22"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  username                    = "dbadmin"
  publicly_accessible         = false
  vpc_security_group_ids      = [var.vpc_security_group_id]
  db_subnet_group_name        = var.db_subnet_group_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_rotation" "rds_foodtech" {
  secret_id = aws_db_instance.db_rds_foodtech.master_user_secret[0].secret_arn

  rotation_rules {
    automatically_after_days = 30
  }
}

output "db_instance_identifier" {
  value = aws_db_instance.db_rds_foodtech.identifier
}
