
variable "role_name" {
}

variable "glue_policy_name_to_access_documentdb" {
}

variable "glue_policy_name_to_access_glue" {
  
}

variable "aws_glue_job_name" {
}


variable "s3_bucket_location_of_glue_script" {
}

variable "glue_version_value" {
  
}

variable "connection_list_for_job" {
  
}


############## Connector
variable "connection_type" {
  
}

variable "connection_name" {
  
}

variable "connection_url" {
  
}

variable "username" {
  
}

variable "password" {
  
}

variable "availability_zone" {
  
}

variable "security_group_id_list" {
  type = list
}

variable "subnet_id" {
  
}

# trigger 

variable "glue_trigger_name" {
  
}

variable "glue_trigger_schedule_expression" {
  
}