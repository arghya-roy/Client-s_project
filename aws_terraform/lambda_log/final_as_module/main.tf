module "log_group" {
  source = "./modules/logs"
  log-group-name = ["art-leads-get-lambda", "art-lead-get-by-id-lambda", "art-lead-create-meterorder-lambda", "art-leads-create-new-lead-lambda-sbx", "art-lead-assign-lambda"]
  retention_in_days = 180
}



