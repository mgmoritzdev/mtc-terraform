variable nodered_cointainer_internal_port {
  type    = number
  default = 1880
}

variable nodered_container_count {
  type    = number
  default = 2

  validation {
    condition = var.nodered_container_count >= 0
    error_message = "The number of containers must be positive."
  }
}
