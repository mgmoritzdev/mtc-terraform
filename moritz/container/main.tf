resource "docker_container" "container" {
  count = var.count_in
  name  = join("-", [var.name_in, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.internal_port_in
    external = var.external_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = docker_volume.container_volume[volumes.key].name
    }
  }
}

resource "docker_volume" "container_volume" {
  count = length(var.volumes_in)
  name  = "${var.name_in}-${count.index}-volume"

  lifecycle {
    prevent_destroy = false
  }
}

resource "random_string" "random" {
  count   = var.count_in
  length  = 4
  special = false
  upper   = false
}
