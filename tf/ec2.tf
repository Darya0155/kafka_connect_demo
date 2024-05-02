

 resource "aws_instance" "web_public_1" {
   ami = "ami-09298640a92b2d12c"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.aws_mks_connect_demo_subnet_public_2.id
   vpc_security_group_ids =[aws_security_group.aws_mks_connect_demo_SG.id]
   key_name = "eks-demo"
   tags = {
     Name = "web_public_1"
   }
   depends_on = [
    aws_msk_cluster.msk_demo
   ]
   user_data = <<-EOF
               #!/bin/bash
               # This script will be executed when the instance starts.
               # Install necessary packages (e.g., Apache) and start HTTP server
               yum update -y
               # yum install -y httpd
               # systemctl start httpd
               # systemctl enable httpd
               yum install -y docker
               service docker start
               docker run  --name web2 -p 8081:8089 -e spring_cloud_stream_kafka_binder_brokers=${aws_msk_cluster.msk_demo.bootstrap_brokers} -d docker.io/deepakarya0155/kubenatiesspringhelloworld:0.0.3
               docker run  --name kafka-ui -p 8080:8080 -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=${aws_msk_cluster.msk_demo.bootstrap_brokers} -e KAFKA_CLUSTERS_0_NAME=msk_demo -e DYNAMIC_CONFIG_ENABLED=true -d provectuslabs/kafka-ui:latest
               EOF
 }

# resource "aws_instance" "kafka_conector_private_2" {
#   ami = "ami-09298640a92b2d12c"
#   instance_type = "t2.small"
#   subnet_id = aws_subnet.aws_mks_connect_demo_subnet_public_1.id
#   vpc_security_group_ids =[aws_security_group.aws_mks_connect_demo_SG.id]
#   key_name = "eks-demo"
#   tags = {
#     Name = "kafka_conector_private_2"
#   }
#   depends_on = [
#     aws_msk_cluster.msk_demo
#   ]
#   user_data = <<-EOF
#               #!/bin/bash
#               # This script will be executed when the instance starts.
#               # Install necessary packages (e.g., Apache) and start HTTP server
#               yum update -y
#               #yum install -y httpd
#               #systemctl start httpd
#               #systemctl enable httpd
#               yum install -y docker
#               service docker start
#               docker run  --name msk-connect -p 8080:8083 -e BOOTSTRAP_SERVERS=${aws_msk_cluster.msk_demo.bootstrap_brokers} -e  GROUP_ID=medium_debezium -e  CONFIG_STORAGE_TOPIC=my_connect_configs -e  OFFSET_STORAGE_TOPIC=my_connect_offsets -e  STATUS_STORAGE_TOPIC=my_connect_statuses -e  CONFIG_STORAGE_REPLICATION_FACTOR=1 -e  OFFSET_STORAGE_REPLICATION_FACTOR=1 -e  STATUS_STORAGE_REPLICATION_FACTOR=1 -d debezium/connect:2.6
#               EOF
# }

 resource "aws_instance" "kafka_conector_private_3" {
   ami = "ami-09298640a92b2d12c"
   instance_type = "t2.small"
   subnet_id = aws_subnet.aws_mks_connect_demo_subnet_public_1.id
   vpc_security_group_ids =[aws_security_group.aws_mks_connect_demo_SG.id]
   key_name = "eks-demo"
   tags = {
     Name = "kafka_conector_private_3"
   }
   depends_on = [
     aws_msk_cluster.msk_demo
   ]
   user_data = <<-EOF
               #!/bin/bash
               # This script will be executed when the instance starts.
               # Install necessary packages (e.g., Apache) and start HTTP server
               yum update -y
               EOF
 }