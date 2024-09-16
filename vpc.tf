/* 
0- creat vpc
1- creat sub1
2- creat sub2
3- security group
(4,5)-rules
*/


# 0
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default" # can add more instance

  tags = {
    Name = "main"
  }
}


#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# 1
resource "aws_subnet" "sub_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet_1"
  }
}
#2
resource "aws_subnet" "sub_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "subnet_2"
  }
}


#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#3
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}


#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#4
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}
#5
resource "aws_vpc_security_group_egress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}