module "autoscaling" {
source = "./modules/autoscaling"
ssh_keypair = var.ssh_keypair
vpc = module.networking.vpc
sg = module.networking.sg
db_config = module.database.db_config
}

module "database" {
source = "./modules/database"
vpc = module.networking.vpc
sg = module.networking.sg
}


module "networking" {
source = "./modules/networking"

}