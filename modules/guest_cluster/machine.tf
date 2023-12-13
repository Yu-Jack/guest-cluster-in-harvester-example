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
            "size": 30,
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
