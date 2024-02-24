variable "ports" {
  type = map(any)
  default = {
    "ssh"   = 22
    "http"  = 80
    "https" = 443
    "sql"   = 3306
  }
}


variable "allow_all" {
  type = object(
    {
      description      = string
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
      security_groups  = list(string)
      # allow traffic from specified aws managed resources
      prefix_list_ids = list(string)
      # allow the instances with same security groups to communicate to each other
      self = bool
    }
  )
  default = {
    description      = "allow all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    # allow traffic from specified aws managed resources
    prefix_list_ids = []
    # allow the instances with same security groups to communicate to each other
    self = false
  }
}

variable "vpc_id" {
  type = string
}