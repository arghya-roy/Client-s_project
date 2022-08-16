module "role" {
  source = "./modules/role"
  role_name = "name1"
  glue_policy_name_to_access_glue = "glue_policy1"

}

module "glue_job" {
  source = "./modules/gluejob"
  for_each = local.jobdetails
  aws_glue_job_name     = each.key
  aws_glue_job_role_arn = module.role.role_arn
  glue_version_value = "3.0"
  s3_bucket_location_of_glue_script = each.value
}
