variable "email" {
    type = string
    default = "saisadhankodurupaka@gmail.com"
  
}
variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type      = string
  sensitive = true
}
