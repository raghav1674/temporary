resource "aws_directory_service_shared_directory" "uswest2" {
  provider = aws.uswest
  for_each     = local.receiver_accounts["prd"]["us-west-2"]
  directory_id = aws_directory_service_directory.primary.id
  target {
    id = each.value
  }
}

resource "aws_directory_service_shared_directory" "useast1" {
  provider = aws.useast
  for_each     = local.receiver_accounts["prd"]["us-east-1"]
  directory_id = aws_directory_service_directory.primary.id
  target {
    id = each.value
  }
  depends_on = [aws_directory_service_region.replicated]
}

resource "aws_directory_service_shared_directory" "cacentral1" {
  provider = aws.cacentral
  for_each     = local.receiver_accounts["prd"]["ca-central-1"]
  directory_id = aws_directory_service_directory.primary.id
  target {
    id = each.value
  }
  depends_on = [aws_directory_service_region.replicated]
}



