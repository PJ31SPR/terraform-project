resource "aws_db_instance" "rds_app" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  identifier           = "patsy-task-app"
  db_name                 = "patsy-task-app-database"
  username             = "root"
  password             = "password"
  skip_final_snapshot  = true
  publicly_accessible = true
}