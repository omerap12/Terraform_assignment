resource "aws_elasticache_subnet_group" "elastic-subnet-group" {
  name       = "elastic-subnet-group"
  subnet_ids = aws_subnet.private-subnet[*].id
}

resource "aws_security_group" "redis_sg" {
  name        = "redis-security-group"
  description = "ElastiCache security group for Redis cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7.2"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.elastic-subnet-group.name
}

data "aws_elasticache_cluster" "my_cluster" {
  cluster_id = "cluster-example"
  depends_on = [ aws_elasticache_cluster.redis ]
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}
