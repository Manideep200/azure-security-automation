terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.0"
        }
    }
}
provider "azurerm"{
    features{}
    resource_provider_registrations = "none"
    subscription_id = "16389ffe-9578-44f0-a2b7-83141fd29b51"
}
resource "azurerm_resource_group""lab"{
    name = "rgp-cyber-lab-01"
    location = var.location
    tags = {
        Environment = "Lab"
        Owner = "Mani"
        SecurityLevel = "High"
        project = "AZ-500-Prep"
    }
}
resource "azurerm_virtual_network""vnet"{
    name = "vnet-cyber-lab"
    address_space = var.vnet_address_space
    location = azurerm_resource_group.lab.location
    resource_group_name = azurerm_resource_group.lab.name
}
resource "azurerm_subnet" "public" {
  name                 = "snet-web"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "private" {
  name                 = "snet-db"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_security_group" "web_nsg" {
  name                = "nsg-web-tier"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "web_assoc" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}
resource "azurerm_network_security_group" "db_nsg" {
  name                = "nsg-dbb-tier"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "DenyIn"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "db_assoc" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}