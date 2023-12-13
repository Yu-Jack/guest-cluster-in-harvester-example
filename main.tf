data "rancher2_cluster_v2" "rancher_cluster" {
  name = "local"
  fleet_namespace = "fleet-local"
}

data "rancher2_cluster_v2" "harvesterkvm" {
  name = "kvm"
  fleet_namespace = "fleet-default"
}

module "guest_cluster"  {
  providers = {
    rancher2 = rancher2
  }

  source = "./modules/guest_cluster"

  cluster_name = "local-test"
  rke2_version = "v1.26.10+rke2r2"
}