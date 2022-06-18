// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

resource "random_string" "nodered_container_sufix" {
  count   = local.nodered_container_count
  length  = 4
  special = false
  upper   = false
}

module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]
}

module "container" {
  source = "./container"
  count = local.nodered_container_count
  name_in = join("-", ["nodered", random_string.nodered_container_sufix[count.index].result])
  image_in = module.image.image_out
  internal_port_in = var.nodered_container_internal_port
  external_port_in = var.nodered_container_external_ports[terraform.workspace][count.index]
  volume_container_path_in = "/data"
}
