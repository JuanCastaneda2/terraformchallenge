data "azurerm_platform_image" "ubuntu" {
  location  = "Central US"
  publisher = "canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20.04-LTS"
}