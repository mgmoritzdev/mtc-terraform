resource "docker_container" "nodered_container" {
  name  = var.name_in
  image = var.image_in
  ports {
    internal = var.internal_port_in
    external = var.external_port_in
  }
  volumes {
    container_path = var.volume_container_path_in
    volume_name = docker_volume.container_volume.name
  }
}

resource "docker_volume" "container_volume" {
  name = "${var.name_in}-volume"
  lifecycle {
    prevent_destroy = false
  }
}
