resource "aws_cloudwatch_log_group" "log-group" {
   count = 5
   retention_in_days = 180
   name = var.log-group-name[count.index]
}



