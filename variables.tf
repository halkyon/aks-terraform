variable "name" {}
variable "location" {}

variable "network_cidr" {
  default = "10.1.0.0/16"
}

variable "nodes_cidr" {
  default = "10.1.0.0/20"
}

variable "kubernetes_version" {
  default = "1.16.9"
}

variable "admin_username" {
  default = "azureuser"
}

variable "os_disk_size_gb" {
  default = 100
}

variable "vm_size" {
  default = "Standard_D2_v2"
}

variable "node_count" {
  default = 1
}

variable "min_count" {
  default = 1
}

variable "max_count" {
  default = 2
}
