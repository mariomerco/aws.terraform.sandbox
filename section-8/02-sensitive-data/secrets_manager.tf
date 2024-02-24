resource "aws_db_instance" "mysql_secrets_manager_secret" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = aws_secretsmanager_secret_version.secret.secret_string
  parameter_group_name = "default.mysql5.7"
}

resource "aws_secretsmanager_secret" "secret" {
  name = "mysql_password"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.admin_password
}

