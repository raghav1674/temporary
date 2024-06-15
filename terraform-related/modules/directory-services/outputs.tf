output "directory_id" {
  description = "The ID of the directory"
  value       = aws_directory_service_directory.this.id
}

output "directory_name" {
  description = "The name of the directory"
  value       = aws_directory_service_directory.this.name
}

output "dns_ip_addresses" {
  description = "The IP addresses of the DNS servers for the directory"
  value       = aws_directory_service_directory.this.dns_ip_addresses
}

output "security_group_id" {
  description = "The ID of the security group created for the directory"
  value       = aws_directory_service_directory.this.security_group_id
}


