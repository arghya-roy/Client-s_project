module "all" {
  source = "./modules/all"
  cluster_identifier =  "democluster"
  engine_version     =  "4.0.0"
  username           =  "admin1234"
  password           =  "admin1234"
  instance_class = "db.t3.medium"
  instance_count = 2
  instance_name = "instance"
  role_name = "role_name_to_attach_with_glue"
  glue_policy_name_to_access_documentdb = "access_docdb_from_glue"
  glue_policy_name_to_access_glue = "acess_glue_table"
  aws_glue_job_name = "glue_job_name"
  s3_bucket_location_of_glue_script = "s3://<bucket_name>/demo.py"
  glue_version_value = "3.0"
}


