variable "location" {
default = "westeurope"
}

variable "admin_username" {
default = "azureuser"
}

variable "ssh_public_key" {
  description = "Clé publique SSH pour la VM"
  type        = string
}

variable "api_port" {
default = 3000
description = "Port exposé par l'API"
}