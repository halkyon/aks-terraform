variable "location" {}
variable "name" {}

variable "public_ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "network_cidr" {
  default = "192.168.0.0/16"
}

variable "nodes_cidr" {
  default = "192.168.1.0/24"
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
