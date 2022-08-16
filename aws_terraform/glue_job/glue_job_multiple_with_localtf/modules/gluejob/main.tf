resource "aws_glue_job" "example" {
  name     = var.aws_glue_job_name
  role_arn = var.aws_glue_job_role_arn
   glue_version = var.glue_version_value

  command {
    # script_location = "s3://${aws_s3_bucket.example.bucket}/example.script"
      script_location = var.s3_bucket_location_of_glue_script
  }
}