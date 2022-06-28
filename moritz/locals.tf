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
