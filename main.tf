# Kan-jibou l-RG li déja mcreyi f l-Portal (Read-Only)
data "azurerm_resource_group" "example" {
  name = "1-ce68537d-playground-sandbox" 
}

# Daba ay 7ajja jdid (VNet, NSG) ghadi t-creya wast dak l-RG
resource "azurerm_virtual_network" "main" {
  name                = "vnet-prod-casa"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_network_security_group" "security" {
  name                = "nsg-prod"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" # Reddah '*' bach Checkov i-viriha 100%
    destination_address_prefix = "*"
  }
}