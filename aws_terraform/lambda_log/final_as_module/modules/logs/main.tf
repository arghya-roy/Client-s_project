
resource "aws_cloudwatch_log_group" "log-group" {
   count = length(var.log-group-name)
   retention_in_days = var.retention_in_days
   name = var.log-group-name[count.index]
}



