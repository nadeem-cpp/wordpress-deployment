# # ############################### db ################################

resource "aws_db_instance" "database" {
  allocated_storage = 10
  db_name           = "myAppDB"
  engine            = var.engine
  engine_version    = "8.0.33"
  instance_class    = var.instance_class
  username          = var.username
  password          = var.master_password
  # parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  # availability_zone = var.subnet
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "db_subnet_group"
  description = "subnet group for database"
  subnet_ids  = var.subnet_ids
  #   subnet_ids = module.vpc.subnet_ids["private"]
}
# see if default dbparameter group is listed by using this command
# aws rds describe-db-parameter-groups
# or else create a 1 using resource
# resource "aws_db_parameter_group" "parameter_group_name" {

# }