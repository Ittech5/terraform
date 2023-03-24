# Reasorce-1: Azure Resource Group
resource "azurerm_resource_group" "lk-loganath" {
    name = "lk-loganath"
    location =  "East US"
}
#Resource-2: Create Virtual Network
resource "azurerm_virtual_network" "lk-vnet" {
  name                = "lk-vnet"
  address_space = [ "10.0.0.0/16" ]
  location            = azurerm_resource_group.lk-loganath.location
  resource_group_name = azurerm_resource_group.lk-loganath.name
  tags = {
    "name" = "lk-vnet1"
  }
}
#Resource-3: Create Subnet
resource "azurerm_subnet" "lksubnet" {
    name = "lksubnet"
    resource_group_name = azurerm_resource_group.lk-loganath.name
    virtual_network_name = azurerm_virtual_network.lk-vnet.name
    address_prefixes = [ "10.0.0.0/24" ]
}
#Resource-4: Create Public IP Address
resource "azurerm_public_ip" "lk-pubip1" {
  depends_on = [
    azurerm_virtual_network.lk-vnet,
    azurerm_subnet.lksubnet
  ]
    name = "lk-pubip1"
    resource_group_name = azurerm_resource_group.lk-loganath.name
    location = azurerm_resource_group.lk-loganath.location
    allocation_method = "Static"
    domain_name_label = "app-vm-${random_string.my_random.id}"
    tags = {
      "vnet" = "lk-vnet1"
    }
}

#Resource-5: Create Network Interface
resource "azurerm_network_interface" "lk-vmnic" {
 name = "lk-vmnic"
 location = azurerm_resource_group.lk-loganath.location
 resource_group_name = azurerm_resource_group.lk-loganath.name
 ip_configuration {
   name = "internal"
   subnet_id = azurerm_subnet.lksubnet.id
   private_ip_address_allocation = "Dynamic"
   public_ip_address_id = azurerm_public_ip.lk-pubip1.id
 }
}
