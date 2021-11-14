// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  # host = "unix:///var/run/docker.sock"
}

# resource "docker_image" "ubuntu" {
#   name = "ubuntu:latest"
# }

# resource "docker_container" "foo" {
#   image = docker_image.ubuntu.latest
#   name = "foo"
# }
