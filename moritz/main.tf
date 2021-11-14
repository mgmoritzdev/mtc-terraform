// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~>2.15"
    }
  }
}

provider "docker" {
  # host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# resource "docker_container" "foo" {
#   image = docker_image.ubuntu.latest
#   name = "foo"
# }
