# resource "aws_s3_bucket" "b" {
#   bucket = var.source_bucket_name
# }

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.aws_glue_catalog_database_name
}


resource "aws_glue_registry" "example" {
  registry_name = var.schemas_registry_name
}

resource "aws_glue_schema" "example" {
  schema_name       = var.schema_name
  registry_arn      = aws_glue_registry.example.arn
  data_format       = "AVRO"
  compatibility     = "NONE"
  schema_definition = var.schema_defination_value
  }


  resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.table_name
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://${var.source_data_folder_location}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
    #  name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"

      parameters = {
        "separatorChar" = ","
      }
    }
  
  schema_reference {

  schema_id {
   registry_name = aws_glue_registry.example.registry_name
   schema_name = aws_glue_schema.example.schema_name
  }
     schema_version_number = var.schema_version_number_value
  }
  }
  }