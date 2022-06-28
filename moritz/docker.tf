// https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

module "images" {
  source = "./image"
  for_each = local.deployment
  image_in = each.value.image
  # var.images.nodered[terraform.workspace]
}

module "nodered_container" {
  source = "./container"
  for_each = local.deployment
  count_in = each.value.container_count
  name_in = each.key
  image_in = module.images[each.key].image_out
  internal_port_in = each.value.internal_port
  external_port_in = each.value.external_port
  volume_container_path_in = "/data"
}
