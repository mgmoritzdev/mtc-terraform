variable "images" {
  type = map(map(string))
  default = {
    nodered = {
      dev = "nodered/node-red:latest",
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev = "quay.io/influxdb/influxdb:v2.0.2",
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev = "grafana/grafana-oss",
      prod = "grafana/grafana-oss"
    }
  }
}

variable internal_ports {
  type = map(number)
}

variable external_ports {
  type = map(map(list(number)))
}

variable secret {
  type      = string
  sensitive = true
}

locals {
  deployment = {
    nodered = {
      container_count =  length(var.external_ports["nodered"][terraform.workspace])
      image = var.images["nodered"][terraform.workspace]
      internal_port = var.internal_ports.nodered
      external_port = var.external_ports.nodered[terraform.workspace]
      container_path = "/data"
    }
    influxdb = {
      container_count =  length(var.external_ports["influxdb"][terraform.workspace])
      image = var.images["influxdb"][terraform.workspace]
      internal_port = var.internal_ports.influxdb
      external_port = var.external_ports.influxdb[terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
    grafana = {
      container_count =  length(var.external_ports["grafana"][terraform.workspace])
      image = var.images["grafana"][terraform.workspace]
      internal_port = var.internal_ports.grafana
      external_port = var.external_ports.grafana[terraform.workspace]
      container_path = "/var/lib/grafana"
    }
  }
}
