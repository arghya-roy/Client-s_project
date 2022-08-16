 module "connector_job_and_role" {
   source = "./modules/connector_job_and_role"
   role_name = "role_name_to_attach_with_glue"
   glue_policy_name_to_access_documentdb = "access_docdb_from_glue"
   glue_policy_name_to_access_glue = "acess_glue_table"
   aws_glue_job_name = "glue_job_name"
   s3_bucket_location_of_glue_script = "s3://bnnb/demo.py"
   glue_version_value = "3.0"
   connection_list_for_job = ["example"]


   connection_type = "MONGODB"
   connection_name = "example"
   connection_url = "mongodb://host_name:80/db_name"
   username = "username"
   password = "password"
   availability_zone = "ap-south-1b"
   security_group_id_list = [
                  "sg-082e513ec2ba46342",
                  "sg-0971fa046ed455b48",
                  "sg-0ee3aca814e605d1b"
                ]
   subnet_id = "subnet-id"


}

