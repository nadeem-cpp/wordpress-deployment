# variable "subnets" {
#   type    = set(string)
#   default = ["subnet-003a1f05fb5122dd1", "subnet-0ed74f5884e560bc2"]
# }

# variable "instance_id" {
#   type = string
# }



variable "vpc_id" {
  type = string
  default = "vpc-0d4569dd17aef6fea"
}
# variable "subnet_id" {
#   type = string
# }

# db
variable "db_password" {
  sensitive = true
  type      = string
  default = "12345678"
}

variable "db_username" {
  sensitive = true
  type      = string
  default = "admin"
}


variable "database_engine" {
  type    = string
  default = "mysql"
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}


