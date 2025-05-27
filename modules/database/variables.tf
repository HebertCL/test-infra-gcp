variable "region" {}

variable "vpc_id" {
  description = "VPC ID to connect instance"
}

variable "vpc_self_link" {
  description = "VPC full URL to associate to DB instance"
}

variable "database_instance_name" {
  description = "Name for the database instance"
}
variable "database_version" {
  description = "Database engine to be used"
  default = null
}

variable "database_tier" {
  description = "Database instance type"
  default = null
}
