resource "rancher2_cloud_credential" "harvesterkvm" {
  name = var.harvester_cloud_crenditial_name
  harvester_credential_config {
    cluster_id         = data.rancher2_cluster_v2.harvesterkvm.cluster_v1_id
    cluster_type       = "imported"
    kubeconfig_content = data.rancher2_cluster_v2.harvesterkvm.kube_config
  }
}