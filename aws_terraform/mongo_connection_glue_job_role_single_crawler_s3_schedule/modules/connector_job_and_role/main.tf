
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

resource "aws_iam_role_policy_attachment" "attach_with_cloudwatch" {
  role       = aws_iam_role.role1.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
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


resource "aws_iam_policy" "policy_to_access_glue_table_and_ec2" {
  name        = var.glue_policy_name_to_access_glue
  path        = "/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*",
                "ec2:*"
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
  policy_arn = aws_iam_policy.policy_to_access_glue_table_and_ec2.arn
}


resource "aws_glue_job" "example" {
  name     = var.aws_glue_job_name
  role_arn = aws_iam_role.role1.arn
  glue_version = var.glue_version_value

  command {
    # script_location = "s3://${aws_s3_bucket.example.bucket}/example.script"
      script_location = var.s3_bucket_location_of_glue_script
  }
  connections = var.connection_list_for_job
}



######################### Connector
resource "aws_glue_connection" "example" {
    connection_type = var.connection_type
    name = var.connection_name
  connection_properties = {
    CONNECTION_URL = var.connection_url
    USERNAME            = var.username
    PASSWORD            = var.password
    
  }

  physical_connection_requirements {
                availability_zone = var.availability_zone
                security_group_id_list = var.security_group_id_list
                subnet_id = var.subnet_id
              }


}





