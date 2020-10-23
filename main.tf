module "vpc" {
  source 			   		= "./modules/vpc"
  awsenv 			  	 	= var.awsenv
  vpc_cidr					= var.vpc_cidr
  subnet1					= var.subnet1
  subnet2					= var.subnet2
  subnet1-private				= var.subnet1-private
  subnet2-private				= var.subnet2-private
  public_cidr					= var.public_cidr
}


module "ec2" {
  source                                        = "./modules/ec2"
  awsenv                                        = var.awsenv
  security_groups				= module.vpc.security_groups
  number_of_app_servers				= var.number_of_app_servers
  number_of_worker_servers                      = var.number_of_worker_servers
  ami						= var.ami
  instance_type					= var.instance_type
  subnet_id					= list("${module.vpc.subnet1}", "${module.vpc.subnet2}")
  subnet_id_private				= list("${module.vpc.subnet1-private}", "${module.vpc.subnet2-private}")
}

module "elb" {
  source                                        = "./modules/elb"
  awsenv                                        = var.awsenv
  security_groups				= module.vpc.security_groups
  subnets                 			= list("${module.vpc.subnet1}", "${module.vpc.subnet2}")
  vpc_id					= module.vpc.vpc_id
  target_servers				= module.ec2.app-servers
}

module "elasticache" {
  source                                        = "./modules/elasticache"
  redis_node_type				= var.redis_node_type
  redis_num_cache_nodes				= var.redis_num_cache_nodes
  redis_port					= var.redis_port
  redis_engine_version				= var.redis_engine_version
  subnet_ids					= list("${module.vpc.subnet1}", "${module.vpc.subnet2}")
  security_group_ids				= module.vpc.security_groups
  memcached_node_type				= var.memcached_node_type
  memcached_num_cache_nodes			= var.memcached_num_cache_nodes
  memcached_port				= var.memcached_port
}

module "aurora" {
  source                                        = "./modules/aurora"
  security_groups                               = module.vpc.security_groups
  subnet_ids                                    = list("${module.vpc.subnet1-private}", "${module.vpc.subnet2-private}")
  instance_class				= var.instance_class
  instance_count				= var.instance_count
  master_username				= var.master_username
  master_password				= var.master_password
  engine_version				= var.engine_version
}

