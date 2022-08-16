module "role" {
  source = "./modules/role"
  role_name = "name1"
  glue_policy_name_to_access_glue = "glue_policy1"

}

module "glue_job" {
  source = "./modules/gluejob"
  aws_glue_job_role_arn = module.role.role_arn
  glue_version_value = "3.0"
  
  jobdetails = {
    "name1"         = "s3://bnnb/example1.script",
    "name2"         = "s3://bnnb/example2.script",
    "name3"         = "s3://bnnb/example3.script",
    "name4"         = "s3://bnnb/example4.script"
  } 

  



}
