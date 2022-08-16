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
   connection_url = "mongodb://docdb-2022-08-03-05-20-20.cluster-ccxfheddgpcd.ap-south-1.docdb.amazonaws.com:27017/db1"
   username = "username"
   password = "password"
   availability_zone = "ap-south-1b"
   security_group_id_list = ["sg-012d4adcd917bb26d", "sg-093c37ca1320154d3"]
   subnet_id = "subnet-0d67a3ac0b4e3c40c"


# vpc endpoint stuffs -
   vpc_id_for_vpc_endpoint = "vpc-0deb0ba0e6a"
   route_table_ids = ["rtb-0a5370be1000"]
   service_name = "com.amazonaws.<region>.s3"


}

