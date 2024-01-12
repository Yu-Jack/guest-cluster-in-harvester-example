
data "local_file" "cloud_init" {
  filename = "${path.module}/../../cloud-init-template"
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
            "imageName": "${var.image_name}", 
            "size": 15,
            "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "${var.network_name}"
        }]
    }
    EOF
    ssh_user = "ubuntu"
    user_data = <<EOF
    package_update: true
    # This is for reinstalling harvester cloud provider.
    # If you don't need to reinstall, you can remote write_files
    write_files:
      - encoding: b64
        content: ${base64encode(local.cloud_provider_config_content)}
        owner: root:root
        path: /etc/kubernetes/cloud-config
        permission: '0644'
    ${indent(4, data.local_file.cloud_init.content)}
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
