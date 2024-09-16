/* 
0-creat gsub
1-creat db instance
*/
#0
resource "aws_db_subnet_group" "gsub_1" {
  name       = "gsubnet_1"
  subnet_ids = [aws_subnet.sub_1.id, aws_subnet.sub_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}
#1
resource "aws_db_instance" "First_Db" {
  allocated_storage    = 20
  db_name              = "mydb627"
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  username             = "malek"
  password             = "malek#123"
  parameter_group_name = "default.postgres15"
  db_subnet_group_name=  aws_db_subnet_group.gsub_1.name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  skip_final_snapshot  = true
  multi_az = false
}
