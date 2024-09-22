output "directory_id" {
  description = "The ID of the directory"
  value       = aws_directory_service_directory.primary.id
}

output "dns_ip_addresses" {
  description = "The IP addresses of the DNS servers for the directory"
  value       = aws_directory_service_directory.primary.dns_ip_addresses
}

output "security_group_id" {
  description = "The ID of the security group created for the directory"
  value       = aws_directory_service_directory.primary.security_group_id
}


