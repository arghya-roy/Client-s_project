resource "aws_glue_job" "example" {
role_arn = var.aws_glue_job_role_arn
glue_version = var.glue_version_value
 
    for_each = var.jobdetails 
    name   = each.key
    command {
         script_location = each.value     
    } 
  }