output "app-servers" {
  value = aws_instance.app-servers.*.id
}

output "worker-servers" {
  value = aws_instance.worker-servers.*.id
}

output "private_key_pem" {
  value = tls_private_key.ec2-keys.private_key_pem
}
