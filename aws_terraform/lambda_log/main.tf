# resource "aws_cloudwatch_log_group" "cloudwatch-art-leads-get-lambda" {
#   name =   "/aws/lambda/art-leads-get-lambda${var.cloudwatch-art-leads-get-lambda-name}"  
#   retention_in_days = 180
# }
# resource "aws_cloudwatch_log_group" "cloudwatch-art-lead-get-by-id-lambda" {
#   name =   "/aws/lambda/art-lead-get-by-id-lambda${var.cloudwatch-art-lead-get-by-id-lambda-name}"  
#   retention_in_days = 180
# }
# resource "aws_cloudwatch_log_group" "cloudwatch-art-lead-create-meterorder-lambda" {
#   name =   "/aws/lambda/art-lead-create-meterorder-lambda${var.cloudwatch-art-lead-create-meterorder-lambda-name}"  
#   retention_in_days = 180
# }
# resource "aws_cloudwatch_log_group" "cloudwatch-art-leads-create-new-lead-lambda-sbx" {
#   name =   "/aws/lambda/art-leads-create-new-lead-lambda-sbx${var.cloudwatch-art-leads-create-new-lead-lambda-sbx-name}"  
#   retention_in_days = 180
# }
# resource "aws_cloudwatch_log_group" "cloudwatch-art-lead-assign-lambda" {
#   name =   "/aws/lambda/art-lead-assign-lambda${var.cloudwatch-art-lead-assign-lambda-name}"  
#   retention_in_days = 180
# }

resource "aws_cloudwatch_log_group" "log-group" {
   count = 5
   retention_in_days = 180
   name = var.log-group-name[count.index]
}



