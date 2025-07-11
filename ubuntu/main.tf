resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = ""
  tags     = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.hostname}-NIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = var.ipType
  }
  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.hostname
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  size                            = split(",", var.VmSize)[0]
  computer_name                   = var.hostname
  admin_username                  = data.azurerm_key_vault_secret.wgadminuser.value
  admin_password                  = data.azurerm_key_vault_secret.wgadminpass.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]
  secure_boot_enabled             = "true"
  os_disk {
    name                 = "${var.hostname}-os-disk"
    disk_size_gb         = "100"
    caching              = var.oscaching
    storage_account_type = var.OS_storageaccType
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = var.identity
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = var.tags
}

// resource "azurerm_managed_disk" "disk" { 
//   count                = var.diskcreate
//   name                 = "${var.hostname}-datadisk-${count.index + 1}"
//   location            = var.location 
//   resource_group_name  = azurerm_resource_group.rg.name
//   storage_account_type = var.datadisk_storageaccType
//   create_option        = "Empty"
//   disk_size_gb         = var.disksizegb[count.index]
//   tags     = var.tags
// }

// resource "azurerm_virtual_machine_data_disk_attachment" "diskattach" { 
//   count              = var.diskcreate
//   managed_disk_id    = azurerm_managed_disk.disk[count.index].id
//   virtual_machine_id = azurerm_linux_virtual_machine.vm.id
//   lun                = 1+count.index
//   create_option     = "Attach"
//   caching            = var.diskcaching
// }

