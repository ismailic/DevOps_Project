# Hna kandirou l-Resource Group li déjà 3ndek f l-image
resource "azurerm_resource_group" "example" {
  name     = "1-489a8467-playground-sandbox" # Smit l-RG li f l-image
  location = "East US"                       # L-location li f l-image
}

# VNet wast dak l-Resource Group
resource "azurerm_virtual_network" "main" {
  name                = "vnet-prod-casa"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# NSG m3a l-ghalta d Port 22 bach i-detectiha Checkov
resource "azurerm_network_security_group" "security" {
  name                = "nsg-prod"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "41.251.42.30" # <--- HADI HIA L-GHALTA L-MA9SOUDA
    destination_address_prefix = "*"
  }
}