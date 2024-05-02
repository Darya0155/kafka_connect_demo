resource "aws_mskconnect_connector" "msk_demo_connector" {
  name = "mskDemoConnector"

  kafkaconnect_version = "2.7.1"

  capacity {
    autoscaling {
      mcu_count        = 1
      min_worker_count = 1
      max_worker_count = 2

      scale_in_policy {
        cpu_utilization_percentage = 20
      }

      scale_out_policy {
        cpu_utilization_percentage = 80
      }
    }
  }

  connector_configuration = {
    "connector.class"= "io.debezium.connector.mysql.MySqlConnector",
    "tasks.max"= "1",
    "database.hostname"= aws_db_instance.msk_demo_rds.address,
    "database.port"= "3306",
    "database.user"= aws_db_instance.msk_demo_rds.username,
    "database.password"= aws_db_instance.msk_demo_rds.password,
    "database.server.id"= "123456",
    "database.include.list"= "msk_demo",
    "topic.prefix"= "topic",
    "database.history.kafka.bootstrap.servers"= aws_msk_cluster.msk_demo.bootstrap_brokers,
    "schema.history.internal.kafka.topic"= "msk_demo.Persons",
    "schema.history.internal.kafka.bootstrap.servers"= aws_msk_cluster.msk_demo.bootstrap_brokers,
    "table.history.internal.kafka.topic"= "msk_demo.table",
    "table.history.internal.kafka.bootstrap.servers"= aws_msk_cluster.msk_demo.bootstrap_brokers,
    "include.schema.changes"= "true",
    "table.include.list": "msk_demo.Persons"

  }

  kafka_cluster {
    apache_kafka_cluster {
      bootstrap_servers =  aws_msk_cluster.msk_demo.bootstrap_brokers

      vpc {
        security_groups = [aws_security_group.aws_mks_connect_demo_SG.id]
        subnets         = [ aws_subnet.aws_mks_connect_demo_subnet_private_2.id,
          aws_subnet.aws_mks_connect_demo_subnet_private_1.id]
      }
    }
  }

  kafka_cluster_client_authentication {
    authentication_type = "NONE"
  }

  kafka_cluster_encryption_in_transit {
    encryption_type = "PLAINTEXT"
  }

  plugin {
    custom_plugin {
      arn      = aws_mskconnect_custom_plugin.example.arn
      revision = aws_mskconnect_custom_plugin.example.latest_revision
    }
  }

  service_execution_role_arn = aws_iam_role.kafka_role.arn
  worker_configuration {
    arn      = aws_mskconnect_worker_configuration.mskconnect_demo_worker.arn
    revision = aws_mskconnect_worker_configuration.mskconnect_demo_worker.latest_revision
  }

}