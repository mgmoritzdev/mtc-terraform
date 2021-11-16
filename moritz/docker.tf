// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

resource "random_integer" "nodered_container_external_port" {
  count = var.nodered_container_count
  min   = 8000
  max   = pow(2, 16) - 1
}

resource "random_string" "nodered_container_sufix" {
  count   = var.nodered_container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = var.nodered_container_count
  name  = join("-", ["nodered", random_string.nodered_container_sufix[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.nodered_cointainer_internal_port
    external = random_integer.nodered_container_external_port[count.index].result
  }
}
