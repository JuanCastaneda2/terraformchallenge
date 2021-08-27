data "azurerm_platform_image" "ubuntu" {
  location  = "Central US"
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "20.04-LTS"
}