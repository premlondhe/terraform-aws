variable "number_of_app_servers" {}
variable "number_of_worker_servers" {}
variable "ami" {}
variable "instance_type" {}
variable "security_groups" {}
variable "key_name" {
  default="ec2-key"
}
variable "subnet_id" {}
variable "awsenv" {}
variable "subnet_id_private" {}
