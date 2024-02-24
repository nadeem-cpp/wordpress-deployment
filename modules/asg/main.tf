resource "aws_launch_template" "wordpress_template" {
  name        = "wordpress_template"
  description = "this template will launch ec2 instance with ubuntu OS to host wordpress website"

  # extra storage
  # block_device_mappings {
  #   device_name = "/dev/sdf"
  #   ebs {
  #     volume_size = 10
  #   }
  # }
  image_id      = "ami-015bb1840f36c7f4d"
  instance_type = "t2.micro"
  key_name = "wordpress-key"
  iam_instance_profile {
    # name = "ec2Role"
    arn =  "arn:aws:iam::551082148216:instance-profile/ec2Profile"
  }


  vpc_security_group_ids = var.sg_ids
  # user_data              = filebase64("${path.module}/example.sh")
}


resource "aws_autoscaling_group" "asg_target_group" {
  name     = "wordpress-asg-group"
  min_size = 1
  max_size = 2
  # availability_zones = [ "ap-south-1a", "ap-south-1b" ]
  vpc_zone_identifier = var.availability_zones
  launch_template {
    id = aws_launch_template.wordpress_template.id
    # version = "$Latest"
    version = aws_launch_template.wordpress_template.latest_version
  }

  target_group_arns = var.target_group_arns
}