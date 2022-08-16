
resource "aws_iam_role" "role1" {
  name = var.role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

}

resource "aws_iam_role_policy_attachment" "attach_with_s3" {
  role       = aws_iam_role.role1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_policy" "policy_to_access_documentdb" {
  name        = var.glue_policy_name_to_access_documentdb
  path        = "/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds:*",
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "attach_with_docdb" {
  role       = aws_iam_role.role1.name
  policy_arn = aws_iam_policy.policy_to_access_documentdb.arn
}


resource "aws_iam_policy" "policy_to_access_glue_table" {
  name        = var.glue_policy_name_to_access_glue
  path        = "/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*",
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "attach_with_glue_table" {
  role       = aws_iam_role.role1.name
  policy_arn = aws_iam_policy.policy_to_access_glue_table.arn
}


resource "aws_glue_job" "example" {
  name     = var.aws_glue_job_name
  role_arn = aws_iam_role.role1.arn
  glue_version = var.glue_version_value

  command {
    # script_location = "s3://${aws_s3_bucket.example.bucket}/example.script"
      script_location = var.s3_bucket_location_of_glue_script
  }
}


resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "docdb"
  engine_version          = var.engine_version
  master_username         = var.username
  master_password         = var.password
  skip_final_snapshot     = true
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "${var.instance_name}-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
}


