resource "aws_iam_role" "test_role1" {
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

resource "aws_iam_role_policy_attachment" "test-attach1" {
  role       = aws_iam_role.test_role1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy" "policy2" {
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

resource "aws_iam_role_policy_attachment" "test-attach2" {
  role       = aws_iam_role.test_role1.name
  policy_arn = aws_iam_policy.policy2.arn
}

