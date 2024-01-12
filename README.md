# Introduction

This repo demos how to create cluster on top of harvester. In other words, you could use virtual machine to start the RKE2 cluster in the virtual machine of harvester on Rancher. 

![image](https://github.com/Yu-Jack/guest-cluster-in-harvester-example/assets/6960289/81e6d5d3-b04e-46a4-9ca2-3525d7daedfc)

More detail about this, please see [Harvester Node Driver](https://docs.harvesterhci.io/v1.2/rancher/node/node-driver/) and [Virtualization on Kubernetes with Harvester](https://ranchermanager.docs.rancher.com/integrations-in-rancher/harvester).

# Bootstrap

1. Have a harvester cluster
2. Have a rancher cluster
3. Import harvester cluster
4. Create access and secret key in rancher GUI, and copy it to `terraform.tfvars`. (use `cp terraform.tfvars.example terraform.tfvars` first)
5. Upload the cloud image in image tab of harvester cluster (`harvester-public` namespace)
    For example, `focal-server-cloudimg-amd64.img` in https://cloud-images.ubuntu.com/focal/current/
6. Create `vlan1` in VM Network tab of harvester cluster
7. `terraform init` and `terraform apply`

There are two different cloud provider you could try

1. default: `terraform apply -target=module.guest_cluster`
2. harvester-cloud-provider: `terraform apply -target=module.guest_cluster_harvester_cloud_provider`

# Terraform Documentation

- https://registry.terraform.io/providers/rancher/rancher2/latest

# Import Example

```sh
# harvester cloud credential
terraform import rancher2_cloud_credential.harvesterkvm "cattle-global-data:cc-xxxxx.harvester"

# guest cluster
terraform import module.guest_cluster.rancher2_cluster_v2.rancher_guest_cluster fleet-default/local-test
```
