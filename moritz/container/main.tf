resource "docker_container" "container" {
  count = var.count_in
  name  = join("-", [var.name_in, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.internal_port_in
    external = var.external_port_in[count.index]
  }
  volumes {
    container_path = var.volume_container_path_in
    volume_name    = docker_volume.container_volume[count.index].name
  }
}

resource "docker_volume" "container_volume" {
  count = var.count_in
  name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
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
