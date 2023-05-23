module "instances" {
  source                        = "./modules/instance"
  instances-security-group-ids  = [module.netowrk-settings.security-group-id]
  piravte-instances-subnets-ids = module.netowrk-settings.private-subnets-ids
  public-instances-subnets-ids  = module.netowrk-settings.public-subnets-ids

  private-instance-user-data = var.private-instance-user-data
  public-instance-user-data  = var.public-instance-user-data
  private-dns-name           = module.netowrk-settings.private-load-balancer-dns


}

module "netowrk-settings" {
  source                      = "./modules/network"
  public-subnets-cidr-blocks  = var.public-subnets
  private-subnets-cidr-blocks = var.private-subnets
  zones                       = var.availability-zones
  private-target-group-ids    = module.instances.private-instances-ids
  public-target-group-ids     = module.instances.public-instances-ids

}
