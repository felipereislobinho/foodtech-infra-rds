
variable "vpc_id" {
  description = "VPC ID to create the security group in"
  type        = string
}

resource "aws_security_group" "sg_rds_foodtech" {
  name   = "rds-prod-securitygroup"
  vpc_id = var.vpc_id

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

  # tags = {
  #   Project     = "rms"
  #   Terraform   = "true"
  #   Environment = "prod"
  # }
 
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name        = "rds-prod-securitygroup"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}

output "security_group_id" {
  value = aws_security_group.sg_rds_foodtech.id
}
 