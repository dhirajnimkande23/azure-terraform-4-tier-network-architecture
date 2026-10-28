# Generic Input Variables
#Business Division
variable "business_division" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  #default = "Azure"
}

#Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  #default = "dev"
  type = string
}

#Azure Resource Group Name
variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
  # default = "rg-default"
}

#azure Resource Group Location
variable "resource_group_location" {
  description = "Azure Resource Group Location"
  type        = string
  #default = "East US"
}


