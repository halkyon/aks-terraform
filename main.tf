terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "group" {
  name     = var.name
  location = var.location
}

resource "azurerm_virtual_network" "network" {
  name                = var.name
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  address_space       = [var.network_cidr]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = azurerm_resource_group.group.name
  address_prefixes     = [var.subnet_cidr]
  virtual_network_name = azurerm_virtual_network.network.name
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.name
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  dns_prefix          = var.name
  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }
  default_node_pool {
    name                  = var.name
    enable_node_public_ip = false
    type                  = "VirtualMachineScaleSets"
    enable_auto_scaling   = true
    node_count            = var.node_count
    min_count             = var.min_count
    max_count             = var.max_count
    vm_size               = var.vm_size
    os_disk_size_gb       = var.os_disk_size_gb
    vnet_subnet_id        = azurerm_subnet.subnet.id
  }
  network_profile {
    network_plugin = "kubenet"
  }
  identity {
    type = "SystemAssigned"
  }
}
