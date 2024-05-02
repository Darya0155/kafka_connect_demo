resource "aws_db_subnet_group" "msk_demo_rds_subnet_group" {
  name       = "msk_demo_rds_subnet_group"
  subnet_ids = [aws_subnet.aws_mks_connect_demo_subnet_public_2.id,aws_subnet.aws_mks_connect_demo_subnet_public_1.id]
  description = "msk_demo_rds_subnet_group"
}


resource "aws_db_instance" "msk_demo_rds" {
  identifier            = "mskdemords"
  instance_class        = "db.t3.micro"
  engine                = "mysql"
  engine_version        = "8.0.35"
  allocated_storage     = 20
  username              = var.data.username
  password              = var.data.password
  vpc_security_group_ids = [aws_security_group.aws_mks_connect_demo_SG.id]  # Reference to a security group
  db_subnet_group_name     = aws_db_subnet_group.msk_demo_rds_subnet_group.name  # Reference to the DB subnet group
  publicly_accessible = true
  skip_final_snapshot = true
  backup_retention_period = 1
  delete_automated_backups = true

  parameter_group_name = aws_db_parameter_group.msk_demo_rds_pgn.name
  apply_immediately    = true
}


resource "aws_db_parameter_group" "msk_demo_rds_pgn" {
  name   = "mskdemordspgn"
  family = "mysql8.0"

  parameter {
    name  = "binlog_format"
    value = "ROW"
  }

  lifecycle {
    create_before_destroy = true
  }
}

