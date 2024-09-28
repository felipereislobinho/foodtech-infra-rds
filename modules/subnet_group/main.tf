
variable "subnet_ids" {
  description = "List of Subnet IDs for the subnet group"
  type        = list(string)
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "foodtech_project"
  }
}

output "subnet_group_name" {
  value = aws_db_subnet_group.my_subnet_group.name
}
