# db
variable "username" {
  sensitive = true
  type      = string
}

variable "master_password" {
  sensitive = true
  type      = string
}

variable "engine" {
  type    = string
}

variable "instance_class" {
  type    = string
}

variable "subnet_ids" {
  type = set(string)
}