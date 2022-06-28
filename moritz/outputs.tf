output "app_access" {
  value       = [for x in module.nodered_container[*] : x]
  description = "The name and socket for each application"
}
