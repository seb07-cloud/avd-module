resource "azurerm_network_interface" "srv_nic" {
  name                = "${upper(var.customer_prefix)}_${upper(var.servername)}_${count.index}"
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn_infrastructure.id
    private_ip_address_allocation = "Dynamic"
  }

  count = var.srv_host_count
}

resource "azurerm_windows_virtual_machine" "srv" {
  name                     = "${upper(var.customer_prefix)}_${upper(var.servername)}_${count.index}"
  computer_name            = "${upper(var.customer_prefix)}_${upper(var.servername)}_${count.index}"
  resource_group_name      = var.resourcegroup_name
  location                 = var.resourcegroup_location
  size                     = var.srv_machinetype
  admin_username           = var.adm_user
  admin_password           = var.pw_adm_user
  enable_automatic_updates = "false"
  provision_vm_agent       = "true"
  patch_mode               = "Manual"

  network_interface_ids = [
    azurerm_network_interface.srv_nic.id,
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  count = var.srv_host_count

}

resource "azurerm_managed_disk" "srv_disk01" {
  name                 = "DISK01_${upper(var.customer_prefix)}_${upper(var.servername)}_${count.index}"
  location             = var.resourcegroup_location
  resource_group_name  = var.resourcegroup_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "16"

  count = var.srv_host_count

}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attach01" {
  managed_disk_id    = azurerm_managed_disk.srv_disk01.id
  virtual_machine_id = azurerm_windows_virtual_machine.srv.id
  lun                = 1
  caching            = "ReadWrite"

  count = var.srv_host_count
}

resource "azurerm_managed_disk" "srv_disk02" {
  name                 = "DISK02_${upper(var.customer_prefix)}_${upper(var.servername)}_${count.index}"
  location             = var.resourcegroup_location
  resource_group_name  = var.resourcegroup_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "16"

  count = var.srv_host_count

}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attach02" {
  managed_disk_id    = azurerm_managed_disk.srv_disk01.id
  virtual_machine_id = azurerm_windows_virtual_machine.srv.id
  lun                = 2
  caching            = "ReadWrite"

  count = var.srv_host_count
}
