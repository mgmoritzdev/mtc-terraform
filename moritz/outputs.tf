output "secret_output" {
  value     = var.secret
  sensitive = true
}

output "container_name" {
  value = module.container[*].container_name
}

output "nodered_ip_addresses" {
  value = flatten(module.container[*].ip_addresses)
}
