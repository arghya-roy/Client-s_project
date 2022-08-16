resource "aws_glue_catalog_database" "glue_database_demo" {
  name = var.database_name  # var
  location_uri = "s3://${var.bucket_location}"  # var
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.table_name  # var
  database_name = aws_glue_catalog_database.glue_database_demo.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://${var.bucket_location}"  # var
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "filekey"
      type = "string"
    }

    columns {
      name = "reead_dt"
      type = "string"
    }
}

partition_keys {
  name = "load_dt"
  type = "string"
}
}