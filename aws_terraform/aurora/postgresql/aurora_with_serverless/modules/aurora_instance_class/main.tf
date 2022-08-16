resource "aws_rds_cluster" "example" {
  cluster_identifier = var.cluster_name
  engine             = var.engine
  engine_mode        = var.engine_mode
  engine_version     = var.engine_version
  database_name      = var.initial_database_name
  master_username    = var.master_username
  master_password    = var.master_username
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  port = var.port
  deletion_protection = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot  = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  apply_immediately = var.apply_immediately
  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  serverlessv2_scaling_configuration {
    max_capacity = var.maximum_acus
    min_capacity = var.minimum_acus
  }
}


resource "aws_rds_cluster_instance" "example" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version

}
