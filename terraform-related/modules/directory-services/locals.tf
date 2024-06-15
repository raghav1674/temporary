locals {
  directory_id      = aws_directory_service_directory.this.id
  security_group_id = aws_directory_service_directory.this.security_group_id
}