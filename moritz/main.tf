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
  count = 1
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
  }
}

output "nodered_ip_addresses" {
  value = [for c in docker_container.nodered_container[*]: join(":", [c.ip_address], c.ports[*]["external"])]
}
