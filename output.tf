output "nat_gateway_ip" {
  value = module.vpc.nat_gateway_ip
}

output "security_groups" {
  value = module.vpc.security_groups
}

output "subnet1" {
  value = module.vpc.subnet1
}

output "subnet2" {
  value = module.vpc.subnet2
}

output "subnet1-private" {
  value = module.vpc.subnet1-private
}

output "subnet2-private" {
  value = module.vpc.subnet2-private
}


output "vpc_id" {
  value = module.vpc.vpc_id
}

output "app-servers" {
  value = module.ec2.app-servers
}

output "worker-servers" {
  value = module.ec2.worker-servers
}

output "private_key_pem" {
  value = module.ec2.private_key_pem
}
