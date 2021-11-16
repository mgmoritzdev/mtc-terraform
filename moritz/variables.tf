variable "env" {
  type    = string
  default = "dev"
}

variable "image" {
  type = map
  default = {
    dev = "nodered/node-red:latest",
    prod = "nodered/node-red:latest-minimal"
  }
}

variable nodered_container_internal_port {
  type    = number
  default = 1880
}

variable nodered_container_external_ports {
  type = map(list(number))
}

locals {
  nodered_container_count =  length(lookup(var.nodered_container_external_ports, var.env))
}

variable secret {
  type      = string
  sensitive = true
}
