resource "aws_msk_cluster" "msk_demo" {
  cluster_name           = "mskdemo"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = [
      aws_subnet.aws_mks_connect_demo_subnet_private_2.id,
      aws_subnet.aws_mks_connect_demo_subnet_private_1.id
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 10
      }
    }
    security_groups = [aws_security_group.aws_mks_connect_demo_SG.id]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS_PLAINTEXT"
    }
  }

#  open_monitoring {
#    prometheus {
#      jmx_exporter {
#        enabled_in_broker = true
#      }
#      node_exporter {
#        enabled_in_broker = true
#      }
#    }
#  }
#
#  logging_info {
#    broker_logs {
#      cloudwatch_logs {
#        enabled   = true
#        log_group = aws_cloudwatch_log_group.test.name
#      }
#      firehose {
#        enabled         = true
#        delivery_stream = aws_kinesis_firehose_delivery_stream.test_stream.name
#      }
#      s3 {
#        enabled = true
#        bucket  = aws_s3_bucket.bucket.id
#        prefix  = "logs/msk-"
#      }
#    }
#  }

  tags = {
    foo = "msk_demo"
  }
}
