resource "azurerm_monitor_action_group" "main" {
  name                = "example-actiongroup"
  resource_group_name = azurerm_resource_group.app_rg.name
  short_name          = "exampleact"

  email_receiver {
    name          = "sendtoadmin"
    email_address = var.email
  }
}
resource "azurerm_monitor_metric_alert" "vm_cpu_warning" {
  name                = "vm-cpu-warning"
  resource_group_name = azurerm_resource_group.app_rg.name
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
resource "azurerm_monitor_metric_alert" "vm_cpu_critical" {
  name                = "vm-cpu-critical"
  resource_group_name = azurerm_resource_group.app_rg.name
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
resource "azurerm_monitor_metric_alert" "vm_memory_warning" {
  name                = "vm-memory-warning"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Available memory < 25"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 25
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
resource "azurerm_monitor_metric_alert" "vm_memory_critical" {
  name                = "vm-memory-critical"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_linux_virtual_machine.demo_vm.id]
  description         = "Available memory < 5"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
resource "azurerm_monitor_metric_alert" "psql_memory_warning" {
  name                = "psql-memory-warning"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_postgresql_flexible_server.psql.id]

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name      = "memory_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
resource "azurerm_monitor_metric_alert" "psql_memory_critical" {
  name                = "psql-memory-critical"
  resource_group_name = azurerm_resource_group.app_rg.name
  scopes              = [azurerm_postgresql_flexible_server.psql.id]

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name      = "memory_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}