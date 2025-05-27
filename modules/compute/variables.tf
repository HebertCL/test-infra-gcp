variable "project" {}

variable "region" {}

variable "name" {
  description = "Common name for the compute resources in this module"
}

variable "vpc_name" {
  description = "VPC name to associate compute instances to."
}

variable "subnet_name" {
  description = "Subnet name to associate compute instances to."
}

variable "machine_type" {
  description = "GCE instance type"
  default = null
}

variable "source_image" {
  description = "GCE OS flavor"
  default  = null
}

variable "disk_size_gb" {
  description = "OS disk size"
  default = null
}

variable "disk_type" {
  description = "Disk type"
  default = null
}

variable "health_check_port" {
  description = "Health check port number"
  default = null
}

variable "health_check_path" {
  description = "Path used for compute health check"
  default = null
}

variable "health_check_interval" {
  description = "Time in seconds between health checks"
  default = null
}

variable "min_replicas" {
  description = "minimum amount of replicas available"
}

variable "max_replicas" {
  description = "maximum amount of replicas to scale up"
}

variable "cooldown_period" {
  description = "Time in seconds to start collecting instance information"
  default = null
}

variable "cpu_utilization" {
  description = "Value reflecting CPU utilization for autoscaler to scale. Must be between 0 and 1"
  default = null
}

variable "lb_protocol" {
  description = "Protocol used by LB"
  default = null
}

variable "lb_scheme" {
  description = "Whether LB is external or internal"
  default = null
}

variable "lb_timeout" {
  description = "Timeout in seconds for LB"
  default = null
}

variable "labels" {
  description = "Common labels for compute resources"
  default = null
}

