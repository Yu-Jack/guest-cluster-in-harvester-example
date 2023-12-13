
resource "rancher2_cluster_v2" "rancher_guest_cluster" {
  name                         = var.cluster_name
  cloud_credential_secret_name = var.harvester_cloud_credential_id
  kubernetes_version = var.rke2_version

  rke_config {
    machine_pools {
      name                         = "controlplane-zone1"
      cloud_credential_secret_name = var.harvester_cloud_credential_id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 1
      machine_config {
        kind = rancher2_machine_config_v2.harvesterkvm.kind
        name = rancher2_machine_config_v2.harvesterkvm.name
      }
    }
  }
}
