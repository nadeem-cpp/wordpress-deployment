########### load Balancer security group #################################

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "to allow port 22, 443 and 80 as inbound and all as outbound"
  vpc_id      = var.vpc_id
  ingress = [
    {
      description      = "allow ssh"
      from_port        = var.ports["ssh"]
      to_port          = var.ports["ssh"]
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    },
    {
      description      = "allow http"
      from_port        = var.ports["http"]
      to_port          = var.ports["http"]
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    },
    {
      description      = "allow http"
      from_port        = var.ports["https"]
      to_port          = var.ports["https"]
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    }
  ]


  egress = [var.allow_all]
}

####################### ec2 security group ########################
resource "aws_security_group" "instance_sg" {
  name        = "lb_sg"
  description = "Only allow traffic from lb"
  vpc_id      = var.vpc_id
  ingress = [
    {
      description      = "allow ssh from load balancer"
      from_port        = var.ports["ssh"]
      to_port          = var.ports["ssh"]
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    },
    {
      description      = "allow http"
      from_port        = var.ports["http"]
      to_port          = var.ports["http"]
      protocol         = "tcp"
      cidr_blocks      = [aws_security_group.lb_sg.id]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    },
    {
      description      = "allow http"
      from_port        = var.ports["https"]
      to_port          = var.ports["https"]
      protocol         = "tcp"
      cidr_blocks      = [aws_security_group.lb_sg.id]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    },
        {
      description      = "allow sql connection from instance to rds"
      from_port        = var.ports["sql"]
      to_port          = var.ports["sql"]
      protocol         = "tcp"
      # to allow rds connection, rahter than through load balancer
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      # allow traffic from specified aws managed resources
      prefix_list_ids = []
      # allow the instances with same security groups to communicate to each other
      self = true
    }
  ]


  egress = [var.allow_all]
}