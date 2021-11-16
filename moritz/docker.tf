// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

resource "random_string" "nodered_container_sufix" {
  count   = local.nodered_container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_image" "nodered_image" {
  name = lookup(var.image, var.env)
}

resource "docker_container" "nodered_container" {
  count = local.nodered_container_count
  name  = join("-", ["nodered", random_string.nodered_container_sufix[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.nodered_container_internal_port
    external = lookup(var.nodered_container_external_ports, var.env)[count.index]
  }
  volumes {
    container_path = "/data"
    host_path = "${path.cwd}/nodered-vol"
  }
}

resource "null_resource" "docker_volume" {
  provisioner "local-exec" {
    command = "mkdir -p nodered-vol/ && sudo chown -R 1000:1000 nodered-vol/"
  }
}
