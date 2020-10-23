variable "vpc_cidr" {}
variable "awsenv" {}
variable "subnet1" {}
variable "subnet2" {}
variable "subnet1-private" {}
variable "subnet2-private" {}
variable "public_cidr" {}

variable "number_of_app_servers" {}
variable "number_of_worker_servers" {}
variable "ami" {}
variable "instance_type" {}

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

variable "instance_class" {}
variable "instance_count" {}
variable "master_username" {}
variable "master_password" {}
variable "engine_version" {}
