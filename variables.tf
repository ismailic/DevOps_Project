variable "resource_group_name" { # <--- T-akked hna mamsdou7ch espace
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address_prefix" {
  type = list(string)
}
