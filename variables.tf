variable "azure_region" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
}

variable "dbfs_storage_account" {
  type        = string
  description = "Name of the storage account for DBFS"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "cidr_block" {
  description = "VPC CIDR block range"
  type        = string
  default     = "10.20.0.0/23"
}

variable "private_subnets_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.20.0.0/25"
}

variable "public_subnets_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.20.0.128/25"
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of IP addresses allowed to bypass the storage account firewall"
  default     = []
}

variable "network_security_group_rules_required" {
  type    = string
  default = "AllRules"
}

variable "default_storage_firewall_enabled" {
  description = "Disallow public access to default storage account"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Allow public access to frontend workspace web UI"
  type        = bool
  default     = true
}

variable "databricks_account_host" {
  description = "Databricks Account URL"
  type        = string
}

variable "databricks_account_id" {
  description = "Your Databricks Account ID"
  type        = string
}

variable "databricks_metastore" {
  description = "Databricks UC Metastore"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
