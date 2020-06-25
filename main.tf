terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "~> 2.0"
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

resource "azurerm_subnet" "nodes" {
  name                 = "${var.name}-nodes"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = [var.nodes_cidr]
}

resource "azurerm_kubernetes_cluster" "primary" {
  name                = var.name
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  dns_prefix          = var.name
  kubernetes_version  = "1.16.9"
  network_profile {
    network_plugin = "azure"
  }
  default_node_pool {
    name                  = var.name
    vm_size               = var.vm_size
    enable_auto_scaling   = true
    enable_node_public_ip = false
    os_disk_size_gb       = var.os_disk_size_gb
    node_count            = var.node_count
    min_count             = var.min_count
    max_count             = var.max_count
    vnet_subnet_id        = azurerm_subnet.nodes.id
  }
  identity {
    type = "SystemAssigned"
  }
  # Allow external changes to node_count without interference from Terraform
  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }
}
