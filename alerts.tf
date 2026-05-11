resource "azurerm_monitor_action_group" "main" {
  name                = "task-action-group"
  resource_group_name = var.resource_group_name
  short_name          = "alerts"

  email_receiver {
    name          = "Admin-Saisadhan-email"
    email_address = "saisadhankodurupak@gmail.com"
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "task-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.main.id]

  description = "CPU usage greater than 90 percent"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  frequency   = "PT1M"
  window_size = "PT5M"
  severity    = 0

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "disk_alert" {
  name                = "task-disk-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_linux_virtual_machine.main.id]

  description = "Disk usage greater than 75 percent"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Disk Read Bytes"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }

  frequency   = "PT1M"
  window_size = "PT5M"
  severity    = 1

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}