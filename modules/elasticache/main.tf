resource "aws_elasticache_cluster" "elasticache-redis" {
  cluster_id           = "elasticache-redis"
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_cache_nodes
  parameter_group_name = "default.redis5.0"
  engine_version       = var.redis_engine_version
  port                 = var.redis_port
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnets.name
  security_group_ids   = [var.security_group_ids]
}

resource "aws_elasticache_subnet_group" "redis-subnets" {
  name       = "redis-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "elasticache-memcached" {
  cluster_id           = "elasticache-memcached"
  engine               = "memcached"
  node_type            = var.memcached_node_type
  num_cache_nodes      = var.memcached_num_cache_nodes
  parameter_group_name = "default.memcached1.5"
  port                 = var.memcached_port
  subnet_group_name    = aws_elasticache_subnet_group.memcached-subnets.name
  security_group_ids   = [var.security_group_ids]
}

resource "aws_elasticache_subnet_group" "memcached-subnets" {
  name       = "memcached-subnets"
  subnet_ids = var.subnet_ids
}


