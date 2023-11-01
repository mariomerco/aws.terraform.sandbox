resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
}

resource "mysql_user" "jdoe" {
  user               = "jdoe"
  host               = "%"
  plaintext_password = "password"
}

resource "mysql_user" "test" {
  user               = "jdtestoe"
  host               = "%"
  plaintext_password = "password"
}

