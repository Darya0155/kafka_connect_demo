resource "aws_iam_policy" "kafka_policy" {
  name        = "msk_demo_kafka_policy"
  description = "Policy for managing MSK Tutorial Cluster resources"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "kafka-cluster:Connect",
          "kafka-cluster:AlterCluster",
          "kafka-cluster:DescribeCluster"
        ],
        Resource = "arn:aws:kafka:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${aws_msk_cluster.msk_demo.cluster_name}/*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "kafka-cluster:*Topic*",
          "kafka-cluster:WriteData",
          "kafka-cluster:ReadData"
        ],
        Resource = "arn:aws:kafka:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:topic/${aws_msk_cluster.msk_demo.cluster_name}/*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "kafka-cluster:AlterGroup",
          "kafka-cluster:DescribeGroup"
        ],
        Resource = "arn:aws:kafka:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:group/${aws_msk_cluster.msk_demo.cluster_name}/*"
      }

    ]
  })
}


resource "aws_iam_role" "kafka_role" {
  name               = "kafka_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "kafkaconnect.amazonaws.com"
        },
        "Action": "sts:AssumeRole",
#        "Condition": {
#          "StringEquals": {
#            "aws:SourceAccount": data.aws_caller_identity.current.account_id
#          },
#          "ArnLike": {
#            "aws:SourceArn": "MSK-Connector-ARN"
#          }
#        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.kafka_role.name
  policy_arn = aws_iam_policy.kafka_policy.arn
}

resource "aws_iam_role_policy_attachment" "example_policy_attachment2" {
  role       = aws_iam_role.kafka_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonMSKFullAccess"
}
