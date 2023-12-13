data "rancher2_cluster_v2" "rancher_cluster" {
  name = "local"
  fleet_namespace = "fleet-local"
}

data "rancher2_cluster_v2" "harvesterkvm" {
  name = "kvm"
  fleet_namespace = "fleet-default"
}

resource "rancher2_cloud_credential" "harvesterkvm" {
  name = "harvesterkvm"
  harvester_credential_config {
    cluster_id         = data.rancher2_cluster_v2.harvesterkvm.cluster_v1_id
    cluster_type       = "imported"
    kubeconfig_content = data.rancher2_cluster_v2.harvesterkvm.kube_config
  }
}

resource "rancher2_cluster_v2" "rancher_guest_cluster" {
  name                         = "local-test"
  cloud_credential_secret_name = rancher2_cloud_credential.harvesterkvm.id
  kubernetes_version = "v1.26.10+rke2r2"
  rke_config {
    machine_pools {
      name                         = "controlplane-zone1"
      cloud_credential_secret_name = rancher2_cloud_credential.harvesterkvm.id
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

# Create a new rancher2 machine config v2 using harvester node_driver
resource "rancher2_machine_config_v2" "harvesterkvm" {
  generate_name = "harvesterkvm"
  harvester_config {
    vm_namespace = "default"
    cpu_count = "2"
    memory_size = "4"
    disk_info = <<EOF
    {
        "disks": [{
            "imageName": "harvester-public/image-lfjlr",
            "size": 30,
            "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "harvester-public/vlan1"
        }]
    }
    EOF
    ssh_user = "ubuntu"
    user_data = <<EOF
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - - systemctl
        - enable
        - '--now'
        - qemu-guest-agent.service
    EOF
  }
}
