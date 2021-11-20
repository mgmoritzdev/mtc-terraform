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

variable secret {
  type      = string
  sensitive = true
}

locals {
  nodered_container_count =  length(var.nodered_container_external_ports[terraform.workspace])
  nodered_container_volume_host_path = "${path.cwd}/nodered-vol/${terraform.workspace}"
}
