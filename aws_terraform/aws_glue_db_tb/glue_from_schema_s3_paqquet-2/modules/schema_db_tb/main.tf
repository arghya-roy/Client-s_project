resource "aws_s3_bucket" "b1" {
  bucket = var.source_bucket_name_for_tb1
}

resource "aws_s3_bucket_logging" "b1" {
  bucket = aws_s3_bucket.b1.id

  target_bucket = var.target_log_bucket_for_b1
  target_prefix = var.logging_target_prefix_for_b1
}


resource "aws_s3_bucket" "b2" {
  bucket = var.source_bucket_name_for_tb2
}

resource "aws_s3_bucket_logging" "b2" {
  bucket = aws_s3_bucket.b2.id

  target_bucket = var.target_log_bucket_for_b2
  target_prefix = var.logging_target_prefix_for_b2
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.aws_glue_catalog_database_name
}


resource "aws_glue_registry" "example" {
  registry_name = var.schemas_registry_name
}

resource "aws_glue_schema" "example1" {
  schema_name       = var.schema_name_for_tb1
  registry_arn      = aws_glue_registry.example.arn
  data_format       = "AVRO"
  compatibility     = "NONE"
  schema_definition = var.schema_defination_value_for_tb1
  }

resource "aws_glue_schema" "example2" {
  schema_name       = var.schema_name_for_tb2
  registry_arn      = aws_glue_registry.example.arn
  data_format       = "AVRO"
  compatibility     = "NONE"
  schema_definition = var.schema_defination_value_for_tb2
  }


  resource "aws_glue_catalog_table" "aws_glue_catalog_table1" {
  name          = var.table_name_for_tb1
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://${var.source_data_folder_location_for_tb1}"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }
  
  schema_reference {

  schema_id {
   registry_name = aws_glue_registry.example.registry_name
   schema_name = aws_glue_schema.example1.schema_name
  }
     schema_version_number = var.schema_version_number_value_for_tb1
  }
  }
  }




  resource "aws_glue_catalog_table" "aws_glue_catalog_table2" {
  name          = var.table_name_for_tb2
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://${var.source_data_folder_location_for_tb2}"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }
  
  schema_reference {

  schema_id {
   registry_name = aws_glue_registry.example.registry_name
   schema_name = aws_glue_schema.example2.schema_name
  }
     schema_version_number = var.schema_version_number_value_for_tb2
  }
  }
  }