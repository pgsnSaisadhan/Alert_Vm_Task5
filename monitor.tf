# =========================
# ACTION GROUP
# =========================
resource "azurerm_monitor_action_group" "main" {
  name                = "example-actiongroup"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  short_name          = "exampleact"

  email_receiver {
    name          = "sendtoadmin"
    email_address = var.email
  }
}

# =========================
# VM CPU WARNING
# =========================
resource "azurerm_monitor_metric_alert" "vm_cpu_warning" {
  name                = "vm-cpu-warning"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "CPU > 75%"

  frequency   = "PT5M"
  window_size = "PT5M"
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

# =========================
# VM CPU CRITICAL
# =========================
resource "azurerm_monitor_metric_alert" "vm_cpu_critical" {
  name                = "vm-cpu-critical"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "CPU > 95%"

  frequency   = "PT5M"
  window_size = "PT5M"
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

# =========================
# VM MEMORY WARNING
# =========================
resource "azurerm_monitor_metric_alert" "vm_memory_warning" {
  name                = "vm-memory-warning"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Memory low warning"

  frequency   = "PT5M"
  window_size = "PT5M"
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 250000000  # approx 250MB (Azure uses bytes)
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

# =========================
# VM MEMORY CRITICAL
# =========================
resource "azurerm_monitor_metric_alert" "vm_memory_critical" {
  name                = "vm-memory-critical"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Memory critically low"

  frequency   = "PT5M"
  window_size = "PT5M"
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100000000  # approx 100MB
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}