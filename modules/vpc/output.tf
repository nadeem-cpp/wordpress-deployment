
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}


# output as public and private subnet ids
output "subnet_ids" {
  value = {
    public  = [aws_subnet.my_public_subnet_1.id, aws_subnet.my_public_subnet_2.id]
    private = [aws_subnet.my_private_subnet_1.id, aws_subnet.my_private_subnet_2.id, aws_subnet.my_private_subnet_3.id]
  }
}