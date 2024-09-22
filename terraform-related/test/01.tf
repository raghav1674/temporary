locals {
  receiver_accounts = {
      "us-west-1" = ["123456789012","123456789013"],
      "us-east-1" = ["123456789013"]
  }

}

output "a" {
   value = local.region_to_account_ids
}