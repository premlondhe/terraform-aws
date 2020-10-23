resource "tls_private_key" "ec2-keys" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   	= var.key_name
  public_key 	= tls_private_key.ec2-keys.public_key_openssh
}

resource "aws_instance" "app-servers" {
  count 				= var.number_of_app_servers
  subnet_id				= element(var.subnet_id, count.index)
  ami 					= var.ami
  instance_type 			= var.instance_type
  vpc_security_group_ids 		= [var.security_groups]	
  key_name      			= aws_key_pair.generated_key.key_name

  tags = {
    Environment 			= var.awsenv
  }  
}

resource "aws_instance" "worker-servers" {
  count                                 = var.number_of_worker_servers
  subnet_id                             = element(var.subnet_id_private, count.index)
  ami                                   = var.ami
  instance_type                         = var.instance_type
  vpc_security_group_ids                = [var.security_groups]
  key_name                              = aws_key_pair.generated_key.key_name

  tags = {
    Environment                         = var.awsenv
  }
}

