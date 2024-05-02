resource "aws_s3_bucket" "msk_demo_s3" {
  bucket = "mskdemos3"
}

resource "aws_s3_object" "msk_demo_s3_object" {
  bucket = aws_s3_bucket.msk_demo_s3.id
  key    = "debezium.zip"
  source = "debezium.zip"
}

resource "aws_mskconnect_custom_plugin" "example" {
  name         = "debezium-example"
  content_type = "ZIP"
  location {
    s3 {
      bucket_arn = aws_s3_bucket.msk_demo_s3.arn
      file_key   = aws_s3_object.msk_demo_s3_object.key
    }
  }
}

resource "aws_mskconnect_worker_configuration" "mskconnect_demo_worker" {
  name                    = "mskconnectDemoWorker"
  properties_file_content = <<EOT
key.converter=org.apache.kafka.connect.storage.StringConverter
value.converter=org.apache.kafka.connect.storage.StringConverter
EOT
}