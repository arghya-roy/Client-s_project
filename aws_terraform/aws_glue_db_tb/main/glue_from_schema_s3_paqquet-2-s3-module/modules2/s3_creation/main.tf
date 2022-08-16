resource "aws_s3_bucket" "b1" {
  bucket = var.source_bucket_name_for_tb1
}

resource "aws_s3_bucket" "b2" {
  bucket = var.source_bucket_name_for_tb2
}

resource "aws_s3_bucket_logging" "b1" {
  bucket = aws_s3_bucket.b1.id

  target_bucket = var.target_log_bucket_for_b1
  target_prefix = var.logging_target_prefix_for_b1
}


resource "aws_s3_bucket_logging" "b2" {
  bucket = aws_s3_bucket.b2.id

  target_bucket = var.target_log_bucket_for_b2
  target_prefix = var.logging_target_prefix_for_b2
}
