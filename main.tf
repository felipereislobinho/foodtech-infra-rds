
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = ["eks_vpc"]
  }
}

data "aws_subnet" "eks_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["eks_subnet_a"]
  }
}

data "aws_subnet" "eks_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["eks_subnet_b"]
  }
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = data.aws_vpc.selected_vpc.id
}

module "subnet_group" {
  source    = "./modules/subnet_group"
  subnet_ids = [data.aws_subnet.eks_subnet_a.id, data.aws_subnet.eks_subnet_b.id]
}

module "rds" {
  source                = "./modules/rds"
  vpc_security_group_id = module.security_group.security_group_id
  db_subnet_group_name  = module.subnet_group.subnet_group_name
}
