# Define Local Values in Terraform
locals {
  owners               = "var.business_division"
  environment          = "var.environment"
  resource_name_prefix = "${local.owners}-${local.environment}"
  common_tags = {
    environment = local.environment
    owners      = local.owners
  }
}




#tags = local.common_tags
#name = "${local.resource_name_prefix}-vnet"