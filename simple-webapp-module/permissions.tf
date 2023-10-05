resource "aws_iam_role" "ec2_redis_write_role" {
  name = "ec2-redis-write-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "redis_write_policy" {
  name = "redis-write-policy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = [
        "elasticache:DescribeCacheClusters",
        "elasticache:ListTagsForResource",
        "elasticache:TagResource",
        "elasticache:IncreaseNodeGroupsInGlobalReplicationGroup",
        "elasticache:AddTagsToResource",
        "elasticache:ModifyCacheCluster",
        "elasticache:DecreaseNodeGroupsInGlobalReplicationGroup",
        "elasticache:ModifyReplicationGroup",
        "elasticache:ModifyReplicationGroupShardConfiguration",
        "elasticache:RebalanceSlotsInGlobalReplicationGroup",
        "elasticache:ModifyCacheSubnetGroup",
        "elasticache:FailoverGlobalReplicationGroup",
        "elasticache:RebootCacheCluster",
        "elasticache:RebootReplicationGroup",
        "elasticache:BatchStopUpdateAction",
        "elasticache:BatchApplyUpdateAction"
      ],
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_redis_write_policy" {
  policy_arn = aws_iam_policy.redis_write_policy.arn
  role       = aws_iam_role.ec2_redis_write_role.name
}