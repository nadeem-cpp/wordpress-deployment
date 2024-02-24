variable "security_groups" {
  type = list(string)
}
variable "subnet_ids" {
  type = set(string)
  # default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "vpc_id" {
  type = string
}