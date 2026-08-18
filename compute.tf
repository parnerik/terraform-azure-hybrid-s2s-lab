resource "azurerm_network_interface" "dc02_nic" {
  name                = var.dc02_nic_name
  location            = azurerm_resource_group.hybrid.location
  resource_group_name = azurerm_resource_group.hybrid.name

  dns_servers = [var.dc02_dns_server]

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.identity.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.dc02_private_ip_address
  }



}

resource "azurerm_windows_virtual_machine" "dc02" {
  name                  = var.dc02_vm_name
  resource_group_name   = azurerm_resource_group.hybrid.name
  location              = azurerm_resource_group.hybrid.location
  size                  = var.dc02_vm_size
  admin_username        = var.dc02_admin_username
  admin_password        = var.dc02_admin_password
  network_interface_ids = [azurerm_network_interface.dc02_nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.dc02_image_publisher
    offer     = var.dc02_image_offer
    sku       = var.dc02_image_sku
    version   = var.dc02_image_version
  }

  boot_diagnostics {}
}
