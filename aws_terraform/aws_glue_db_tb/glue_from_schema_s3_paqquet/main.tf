module "all_module" {
  source = "./modules/schema_db_tb"
  source_bucket_name = "mdm-dvc-evt-tmp-123"
  aws_glue_catalog_database_name = "mygluedb"
  schemas_registry_name = "demo_registry"
  schemas_registry_description = "A custom schema registry"
  schema_name = "myschema"
   schema_defination_value = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"dvc_evt_id\", \"type\": \"string\"}, {\"name\": \"dvc_evt_type_cd\", \"type\": \"string\"}, {\"name\": \"bus_obj_cd\", \"type\": \"string\"}, {\"name\": \"ext_evt_name_flg\", \"type\": \"string\"}, {\"name\": \"d1_spr_cd\", \"type\": \"string\"}, {\"name\": \"bo_status_cd\", \"type\": \"string\"}, {\"name\": \"status_upd_dttm\", \"type\": \"string\"}, {\"name\": \"bo_status_reason_cd\", \"type\": \"string\"}, {\"name\": \"dvc_evt_dttm\", \"type\": \"string\"}, {\"name\": \"cre_dttm\", \"type\": \"string\"}, {\"name\": \"version\", \"type\": \"int\"}, {\"name\": \"dvc_evt_end_dttm\", \"type\": \"string\"}, {\"name\": \"bo_data_area\", \"type\": \"string\"}, {\"name\": \"d1_device_id\", \"type\": \"string\"}, {\"name\": \"ilm_dt\", \"type\": \"string\"}, {\"name\": \"ilm_arch_sw\", \"type\": \"string\"}, {\"name\": \"retention_period\", \"type\": \"int\"} ]}"
  schema_version_number_value = "1"
  table_name = "demo_table"
  source_data_folder_location = "mdm-dvc-evt-tmp-123/"  # You can add sub folder here if your data is inside sub folder.
}
module "all_module2" {
  source = "./modules/schema_db_tb"
  source_bucket_name = "mdm-dvc-evt-tmp-1234"
  aws_glue_catalog_database_name = "mygluedb4"
  schemas_registry_name = "demo_registry4"
  schemas_registry_description = "A custom schema registry4"
  schema_name = "myschema4"
   schema_defination_value = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"dvc_evt_id\", \"type\": \"string\"}, {\"name\": \"dvc_evt_type_cd\", \"type\": \"string\"}, {\"name\": \"bus_obj_cd\", \"type\": \"string\"}, {\"name\": \"ext_evt_name_flg\", \"type\": \"string\"}, {\"name\": \"d1_spr_cd\", \"type\": \"string\"}, {\"name\": \"bo_status_cd\", \"type\": \"string\"}, {\"name\": \"status_upd_dttm\", \"type\": \"string\"}, {\"name\": \"bo_status_reason_cd\", \"type\": \"string\"}, {\"name\": \"dvc_evt_dttm\", \"type\": \"string\"}, {\"name\": \"cre_dttm\", \"type\": \"string\"}, {\"name\": \"version\", \"type\": \"int\"}, {\"name\": \"dvc_evt_end_dttm\", \"type\": \"string\"}, {\"name\": \"bo_data_area\", \"type\": \"string\"}, {\"name\": \"d1_device_id\", \"type\": \"string\"} ]}"
  schema_version_number_value = "1"
  table_name = "demo_table4"
  source_data_folder_location = "mdm-dvc-evt-tmp-1234/"  # You can add sub folder here if your data is inside sub folder.
}