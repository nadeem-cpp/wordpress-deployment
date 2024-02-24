variable "sg_ids" {
  type = list(string)
}

variable "target_group_arns" {
  description = "target group arns of load balancer"
  type = list(string)
}

variable "availability_zones" {
  type = set(string)
}