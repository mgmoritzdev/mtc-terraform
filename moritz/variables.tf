variable "images" {
  type = map(map(string))
  default = {
    nodered = {
      dev  = "nodered/node-red:latest",
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2",
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana-oss",
      prod = "grafana/grafana-oss"
    }
  }
}

variable "internal_ports" {
  type = map(number)
}

variable "external_ports" {
  type = map(map(list(number)))
}

variable "secret" {
  type      = string
  sensitive = true
}

variable "volumes_in" {
  type = map(list(map(string)))
}
