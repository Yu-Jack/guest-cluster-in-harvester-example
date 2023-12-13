# Introduction

This repo demos how to create cluster on top of harvester. In other words, you could use virtual machine to start the RKE2 cluster in the virtual machine of harvester.

# Import Example


```sh
# harvester cloud credential
terraform import rancher2_cloud_credential.harvesterkvm "cattle-global-data:cc-xxxxx.harvester"

# guest cluster
terraform import module.guest_cluster.rancher2_cluster_v2.rancher_guest_cluster fleet-default/local-test
```