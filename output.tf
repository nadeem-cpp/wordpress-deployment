# output "instance_ip" {
#   value = {
#     # instance key , instance object
#     # after instances are created, they are saved in state file
#     # so get key, value pair and get useful information
#     for instance_key, instance_value in aws_instance.demo_public :
#     instance_key => instance_value.public_ip

#   }
#   # value = aws_instance.demo_public.[*].public_ip
# }

# # db
# output "db_arn" {
#   value = aws_db_instance.database.arn
# }

