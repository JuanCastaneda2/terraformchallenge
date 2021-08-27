provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraformchallenge" {
  name     = "prueba"
  location = var.location
}

resource "azurerm_virtual_network" "vnetprueba" {
  name                = "vnetprueba"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terraformchallenge.location
  resource_group_name = azurerm_resource_group.terraformchallenge.name
}

resource "azurerm_subnet" "subnetprueba" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.terraformchallenge.name
  virtual_network_name = azurerm_virtual_network.vnetprueba.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nivm1" {
  name                = "nivm1"
  location            = azurerm_resource_group.terraformchallenge.location
  resource_group_name = azurerm_resource_group.terraformchallenge.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetprueba.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = var.instance_name
  resource_group_name = azurerm_resource_group.terraformchallenge.name
  location            = azurerm_resource_group.terraformchallenge.location
  size                = "Standard_F2"
  network_interface_ids = [
    azurerm_network_interface.nivm1.id
  ]
  source_image_id = data.azurerm_platform_image.ubuntu.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "vm1"
  admin_username = "juancas20"
  disable_password_authentication = true
  
  admin_ssh_key {
      username       = "juancas20"
      public_key     = var.public_key
    }
}