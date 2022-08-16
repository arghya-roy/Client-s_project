module "role" {
  source = "./modules/role"
  role_name = "name1"
  glue_policy_name_to_access_glue = "glue_policy1"

}

module "glue_job" {
  source = "./modules/gluejob"
  aws_glue_job_role_arn = module.role.role_arn
  aws_glue_job_name = "name1"
  s3_bucket_location_of_glue_script = "s3://bnnb/example.script"
  glue_version_value = "3.0"
}
