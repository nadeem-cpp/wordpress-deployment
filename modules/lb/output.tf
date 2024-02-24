output "lb_dns" {
  value = aws_lb.load_balancer.dns_name
}

output "lb_target_group" {
  value = aws_lb.load_balancer
}