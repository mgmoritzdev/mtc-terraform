// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.15"
    }
  }
}

provider "docker" {
  # host = "unix:///var/run/docker.sock"
}

resource "random_string" "random" {
  count   = 2
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
  }
}

output "nodered_0_ip_address" {
  value = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
}

output "nodered_1_ip_address" {
  value = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
}
