module "aurora"  {
source = "./modules/aurora_instance_class"

  cluster_name = "example"
  engine             = "aurora-mysql"
  engine_mode        = "provisioned"
  engine_version     = "8.0.mysql_aurora.3.02.0"
  initial_database_name = "test"
  master_username    = "username"
  master_password    = "password"
  vpc_security_group_ids = ["sg-09ebe8852e413ee15"]
  db_subnet_group_name = "default"
  port = "3306"
  deletion_protection = false
  backup_retention_period = "7"
  skip_final_snapshot  = false
  final_snapshot_identifier ="demo"  # "demo${timestamp()}"
  apply_immediately = false
  preferred_backup_window = "04:00-09:00"
  preferred_maintenance_window = "Mon:00:00-Mon:03:00"

  minimum_acus = 0.5
  maximum_acus = 1.0
  
}



