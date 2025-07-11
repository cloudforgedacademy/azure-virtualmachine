data "azurerm_key_vault" "pipelinekvt" {
  name                = var.keyvault
  resource_group_name = var.rg1
}

data "azurerm_key_vault_secret" "wgadminuser" {
  name         = var.wgadminuser
  key_vault_id = data.azurerm_key_vault.pipelinekvt.id
}

data "azurerm_key_vault_secret" "wgadminpass" {
  name         = var.wgadminpwd
  key_vault_id = data.azurerm_key_vault.pipelinekvt.id
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  resource_group_name = var.vnetrg
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_private_dns_zone" "dns" {
  provider            = azurerm.connectivitysubscription
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "CC-HUB-NETWORK-RG"
}