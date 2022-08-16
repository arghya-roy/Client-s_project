



module "all_module" {
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

