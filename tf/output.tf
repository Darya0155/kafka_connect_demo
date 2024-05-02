
output "msk_kafka_cluster_output" {
  value  ={
    brokers=aws_msk_cluster.msk_demo.bootstrap_brokers
    rds_endpoint=aws_db_instance.msk_demo_rds.endpoint
  }
}