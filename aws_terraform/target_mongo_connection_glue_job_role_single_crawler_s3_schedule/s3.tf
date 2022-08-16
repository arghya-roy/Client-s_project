resource "aws_s3_bucket" "b1" {
  bucket = "mdm-dvc-evt-tmp-123"
}

resource "aws_s3_bucket" "b2" {
  bucket = "mdm-dvc-evt-tmp-456"
}

resource "aws_s3_bucket_logging" "b1" {
  bucket = aws_s3_bucket.b1.id

  target_bucket = "bnnb"
  target_prefix = "log1/"
}


resource "aws_s3_bucket_logging" "b2" {
  bucket = aws_s3_bucket.b2.id

  target_bucket = "bnnb"
  target_prefix = "log2/"
}