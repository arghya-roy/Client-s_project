module "all_module" {
  source = "./modules/schema_db_tb"
  source_bucket_name = "my-demo-performance123"
  aws_glue_catalog_database_name = "mygluedb"
  schemas_registry_name = "demo_registry"
  schemas_registry_description = "A custom schema registry"
  schema_name = "myschema"
  schema_defination_value = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"name\", \"type\": \"string\"}, {\"name\": \"demo\", \"type\": \"string\"} ]}"
  schema_version_number_value = "1"
  table_name = "demo_table"
  source_data_folder_location = "bnnb/"
}