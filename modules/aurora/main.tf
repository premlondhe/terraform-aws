resource "aws_rds_cluster" "rds-aurora-mysql" {
  cluster_identifier   = "rds-aurora-mysql"
  engine               = "aurora-mysql"
  db_subnet_group_name = aws_db_subnet_group.aurora-subnets.name
#  engine_mode          = "multimaster"
  master_password      = var.master_password
  master_username      = var.master_username
  skip_final_snapshot  = true
  engine_version       = var.engine_version
}

resource "aws_db_subnet_group" "aurora-subnets" {
  name       = "aurora-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "rds-aurora-mysql-cluster-${count.index}"
  cluster_identifier = aws_rds_cluster.rds-aurora-mysql.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.rds-aurora-mysql.engine
  engine_version     = aws_rds_cluster.rds-aurora-mysql.engine_version
}
