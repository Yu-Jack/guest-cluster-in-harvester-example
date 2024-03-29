data "rancher2_cluster_v2" "rancher_cluster" {
  name            = "local"
  fleet_namespace = "fleet-local"
}

data "rancher2_cluster_v2" "harvesterkvm" {
  name            = var.harvester_name
  fleet_namespace = "fleet-default"
}

module "guest_cluster" {
  providers = {
    rancher2 = rancher2
  }

  source = "./modules/guest_cluster"

  rancher_api_url               = var.rancher_api_url
  rancher_access_key            = var.rancher_access_key
  rancher_secret_key            = var.rancher_secret_key
  cluster_name                  = "local-test"
  rke2_version                  = var.rke2_version
  harvester_cloud_credential_id = rancher2_cloud_credential.harvesterkvm.id
  network_name                  = "harvester-public/vlan1"
  image_name                    = var.image_name
}

module "guest_cluster_harvester_cloud_provider" {
  providers = {
    rancher2 = rancher2
  }

  source = "./modules/guest_cluster_harvester_cloud_provider"

  rancher_api_url               = var.rancher_api_url
  rancher_access_key            = var.rancher_access_key
  rancher_secret_key            = var.rancher_secret_key
  cluster_name                  = "test-local-6"
  rke2_version                  = var.rke2_version
  harvester_cloud_credential_id = rancher2_cloud_credential.harvesterkvm.id
  network_name                  = "harvester-public/vlan1"
  image_name                    = var.image_name
}

# for testing output 
# output "example_output" {
#   value = module.guest_cluster.cloud_provider_config_content
# }