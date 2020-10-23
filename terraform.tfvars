# VPC
vpc_cidr="10.0.0.0/16"
awsenv="Production"
subnet1="10.0.1.0/24"
subnet2="10.0.2.0/24"
subnet1-private="10.0.3.0/24"
subnet2-private="10.0.4.0/24"
public_cidr="0.0.0.0/0"

#EC2
number_of_app_servers="2"
number_of_worker_servers="2"
ami="ami-0947d2ba12ee1ff75"
instance_type="t2.micro"

# Redis
redis_node_type="cache.m4.large"
redis_num_cache_nodes="1"
redis_port="6379"
redis_engine_version="5.0.6"

# Memcached
memcached_node_type="cache.m4.large"
memcached_num_cache_nodes="1"
memcached_port="11211"

# Aurora RDS
instance_class="db.r4.large"
instance_count="3"
master_username="dbadmin"
master_password="Aurora123#"
engine_version="5.7.mysql_aurora.2.03.2"
