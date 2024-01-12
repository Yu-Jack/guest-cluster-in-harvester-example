locals {
  cloud_provider_config_content = file("${path.module}/kvm.config")
}

output "cloud_provider_config_content" {
  value = local.cloud_provider_config_content
}

resource "rancher2_cluster_v2" "rancher_guest_cluster_harvester_cloud_provider" {
  name                         = var.cluster_name
  cloud_credential_secret_name = var.harvester_cloud_credential_id
  kubernetes_version = var.rke2_version

  rke_config {
    machine_pools {
      name                         = "controlerplan"
      cloud_credential_secret_name = var.harvester_cloud_credential_id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = false
      quantity                     = 1
      machine_config {
        kind = rancher2_machine_config_v2.harvesterkvm.kind
        name = rancher2_machine_config_v2.harvesterkvm.name
      }
    }

    machine_pools {
      name                         = "worker"
      cloud_credential_secret_name = var.harvester_cloud_credential_id
      control_plane_role           = false
      etcd_role                    = false
      worker_role                  = true
      quantity                     = 1
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.harvesterkvm.kind
        name = rancher2_machine_config_v2.harvesterkvm.name
      }
    }
    
    machine_selector_config {
      config = <<EOF
      cloud-provider-config: "${local.cloud_provider_config_content}"
      cloud-provider-name: harvester
      EOF
    }

    chart_values = <<EOF
    harvester-cloud-provider:
      cloudConfigPath: /etc/kubernetes/cloud-config
      clusterName: "${var.cluster_name}"
    EOF
  }
}
