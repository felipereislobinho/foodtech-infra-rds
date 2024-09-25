# Arquivo main.tf

# Provider AWS
provider "aws" {
  region = "us-east-1" # Defina sua região AWS aqui
}
 
data "aws_availability_zones" "available" {}

resource "aws_security_group" "sg-rds-fiaptech" {
  name   = "rds-prod-securitygroup"
  vpc_id = "vpc-01fabac4b74d26a00"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = "rms"
    Terraform   = "true"
    Environment = "prod"
  }
  lifecycle {
  prevent_destroy = true
}
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = ["subnet-05a655a9ad4f143b6", "subnet-045e474a5f2cafafb"]

  tags = {
    Name = "My DB subnet group"
  }
}


# Recurso RDS PostgreSQL
resource "aws_db_instance" "db-rds-fiaptech" {
  identifier              = "rds-fiaptech"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "11.22"
  instance_class          = "db.t3.micro"
  manage_master_user_password = true # Guarda o usuário e senha do banco de dados no AWS Secrets Manager
  username                = "dbadmin"
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.sg-rds-fiaptech.id]
  db_subnet_group_name = aws_db_subnet_group.my_subnet_group.name  
 
lifecycle {
  prevent_destroy = true
}
}

 

resource "aws_secretsmanager_secret_rotation" "rds-fiaptech" {
  secret_id = aws_db_instance.db-rds-fiaptech.master_user_secret[0].secret_arn

  rotation_rules {
    automatically_after_days = 30 # (Optional) # O valor padrão é 7 dias
  }
}

# Optionally fetch the secret data if attributes need to be used as inputs
# elsewhere.
data "aws_secretsmanager_secret" "rds-fiaptech" {
  arn = aws_db_instance.db-rds-fiaptech.master_user_secret[0].secret_arn
}

