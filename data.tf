data "azurerm_platform_image" "ubuntu_image" {
  location  = var.location
  publisher = "canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20.04-LTS"
}