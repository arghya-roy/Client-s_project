resource "aws_glue_crawler" "example" {
  database_name = var.db_for_crawler
  name          = var.crawler_name
  role          = var.crawler_arn

  s3_target {
    path = "s3://${var.bucket_name_with_source_folder}"
       # path = "s3://bnnb"
  }

  schedule = var.cron_expression
}