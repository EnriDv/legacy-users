module "network" {
  source   = "./modules/network"
  app_port = var.app_port
}

module "compute" {
  source        = "./modules/compute"
  app_port      = var.app_port
  instance_type = var.instance_type
  iam_profile   = var.iam_profile
  sg_id         = module.network.security_group_id
}