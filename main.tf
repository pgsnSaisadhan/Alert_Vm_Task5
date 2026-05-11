# =========================
# RESOURCE GROUP (EXISTING)
# =========================
data "azurerm_resource_group" "app_rg" {
  name = "monitor-demo-rg"
}

# =========================
# VIRTUAL NETWORK
# =========================
resource "azurerm_virtual_network" "main" {
  name                = "demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
}

# =========================
# SUBNET
# =========================
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# =========================
# NSG
# =========================
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm-nsg"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# =========================
# PUBLIC IP
# =========================
resource "azurerm_public_ip" "vm_ip" {
  name                = "demo-public-ip"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  allocation_method   = "Static"
}

# =========================
# NIC
# =========================
resource "azurerm_network_interface" "main" {
  name                = "demo-nic"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
}

# =========================
# NSG ASSOCIATION
# =========================
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

# =========================
# LINUX VM
# =========================
resource "azurerm_linux_virtual_machine" "demo_vm" {
  name                = "demo-vm"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name

  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.main.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface_security_group_association.example
  ]
}