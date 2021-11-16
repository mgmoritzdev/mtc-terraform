output "nodered_ip_addresses" {
  value = [for c in docker_container.nodered_container[*]: join(":", [c.ip_address], c.ports[*]["external"])]
}

output "secret_output" {
  value = var.secret
}
