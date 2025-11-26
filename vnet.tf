resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}"
  location = var.azure_region
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.cidr_block]
  tags                = var.tags
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project_name}"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "public" {
  name                 = "snet-${var.project_name}-public"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnets_cidr]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_subnet.public, azurerm_network_security_group.nsg]
}

resource "azurerm_subnet" "private" {
  name                 = "snet-${var.project_name}-private"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnets_cidr]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  depends_on        = [azurerm_virtual_network.vnet]
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_subnet.private, azurerm_network_security_group.nsg]
}
