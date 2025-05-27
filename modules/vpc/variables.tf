variable "project" {}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnetworks or not."
  default = null
}

variable "routing_mode" {
  description = "Routing mode to be used in the VPC."
  default = null
}

variable "network_name" {
  description = "VPC name"
}

variable "subnetworks" {
  description = "A map of custom subnets associated with the network"
  default = {}
}

variable "firewalls" {
  description = "A map of custom firewall rules associated with the network"
  default = {}
}
