output "public-ips" {
  value = module.instances.public-ips

}
output "private-ips" {
  value = module.instances.private-ips

}

output "public-dns" {
  value = module.netowrk-settings.public-load-balancer-dns-name
}

output "private-dns" {
  value = module.netowrk-settings.private-load-balancer-dns
}
