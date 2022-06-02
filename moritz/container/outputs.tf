output "ip_addresses" {
  value = [for c in docker_container.nodered_container[*]: join(":", [c.ip_address], c.ports[*]["external"])]
}

output "container_name" {
  value = docker_container.nodered_container[*].name
}
