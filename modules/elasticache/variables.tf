variable "redis_node_type" {
  default="cache.m4.large"
}
variable"redis_num_cache_nodes" {
  default="1"
}
variable "redis_port" {
  default="6379"
}
variable "redis_engine_version" {
  default="5.0.6"
}

variable "memcached_node_type" {
  default="cache.m4.large"
}
variable "memcached_num_cache_nodes" {
  default="1"
}
variable "memcached_port" {
  default="11211"
}


variable "subnet_ids" {}
variable "security_group_ids" {}
