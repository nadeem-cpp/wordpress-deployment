# # ########################## load balancer ##############################


resource "aws_lb" "load_balancer" {
  name = "wp-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
#   subnets            = [for subnet in aws_subnet.public : subnet.id]
subnets = var.subnet_ids
# subnets = [ "subnet-003a1f05fb5122dd1", "subnet-0ed74f5884e560bc2" ]
}



resource "aws_lb_listener" "front_end_listener" {
  port = 80
  protocol = "HTTP"
  load_balancer_arn = aws_lb.load_balancer.arn
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_group.arn
  }
}

# target group

resource "aws_lb_target_group" "wordpress_group" {
  name = "wp-target-group"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.wordpress_group.arn
  target_id = aws_lb.load_balancer.id 
  port             = 80
}