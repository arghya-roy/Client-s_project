# Schema_db_tb
module "schema_db_tb" {
  source = "./modules/schema_db_tb"
  aws_glue_catalog_database_name = "mygluedb"
  schemas_registry_name = "demo_registry"


  schema_name_for_tb1 = "myschema"
  schema_defination_value_for_tb1 = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"dvc_evt_id\", \"type\": \"string\"}, {\"name\": \"dvc_evt_type_cd\", \"type\": \"string\"}, {\"name\": \"bus_obj_cd\", \"type\": \"string\"}, {\"name\": \"ext_evt_name_flg\", \"type\": \"string\"}, {\"name\": \"d1_spr_cd\", \"type\": \"string\"}, {\"name\": \"bo_status_cd\", \"type\": \"string\"}, {\"name\": \"status_upd_dttm\", \"type\": \"string\"}, {\"name\": \"bo_status_reason_cd\", \"type\": \"string\"}, {\"name\": \"dvc_evt_dttm\", \"type\": \"string\"}, {\"name\": \"cre_dttm\", \"type\": \"string\"}, {\"name\": \"version\", \"type\": \"int\"}, {\"name\": \"dvc_evt_end_dttm\", \"type\": \"string\"}, {\"name\": \"bo_data_area\", \"type\": \"string\"}, {\"name\": \"d1_device_id\", \"type\": \"string\"}, {\"name\": \"ilm_dt\", \"type\": \"string\"}, {\"name\": \"ilm_arch_sw\", \"type\": \"string\"}, {\"name\": \"retention_period\", \"type\": \"int\"} ]}"
  schema_version_number_value_for_tb1 = "1"
  table_name_for_tb1 = "demo_table"
  source_data_folder_location_for_tb1 = "${aws_s3_bucket.b1.bucket}/"  # You can add sub folder here if your data is inside sub folder.



  schema_name_for_tb2 = "myschema2"
   schema_defination_value_for_tb2 = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"dvc_evt_id\", \"type\": \"string\"}, {\"name\": \"dvc_evt_type_cd\", \"type\": \"string\"}, {\"name\": \"bus_obj_cd\", \"type\": \"string\"}, {\"name\": \"ext_evt_name_flg\", \"type\": \"string\"}, {\"name\": \"d1_spr_cd\", \"type\": \"string\"}, {\"name\": \"bo_status_cd\", \"type\": \"string\"}, {\"name\": \"status_upd_dttm\", \"type\": \"string\"}, {\"name\": \"bo_status_reason_cd\", \"type\": \"string\"}, {\"name\": \"dvc_evt_dttm\", \"type\": \"string\"}, {\"name\": \"cre_dttm\", \"type\": \"string\"}, {\"name\": \"version\", \"type\": \"int\"}, {\"name\": \"dvc_evt_end_dttm\", \"type\": \"string\"}, {\"name\": \"bo_data_area\", \"type\": \"string\"}, {\"name\": \"d1_device_id\", \"type\": \"string\"}, {\"name\": \"ilm_dt\", \"type\": \"string\"}, {\"name\": \"ilm_arch_sw\", \"type\": \"string\"}, {\"name\": \"retention_period\", \"type\": \"int\"} ]}"
  schema_version_number_value_for_tb2 = "1"
  table_name_for_tb2 = "demo_table2"
  source_data_folder_location_for_tb2 = "${aws_s3_bucket.b2.bucket}/"  # You can add sub folder here if your data is inside sub folder.
}

# connection_job_and_role

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


   glue_trigger_name = "demo_trigger"
   glue_trigger_schedule_expression = "cron(00 10 * * ? *)"
}

## crawler_s3_schedule

module "crawler_s3_schedule" {
 source = "./modules/crawler_s3_schedule"

 db_for_crawler = module.schema_db_tb.db_name_for_crawler
 crawler_name = "demo_name"
 crawler_arn = module.connector_job_and_role.role_arn
 bucket_name_with_source_folder = "bnnb/demo_csv.csv"  
 cron_expression = "cron(00 09 * * ? *)"

}
