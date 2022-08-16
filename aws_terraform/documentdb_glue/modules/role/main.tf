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

