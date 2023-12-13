variable "rancher_api_url" {
  type        = string
  description = "Rancher API URL"
}

variable "rancher_access_key" {
  type        = string
  description = "Access key"
}

variable "rancher_secret_key" {
  type        = string
  description = "Secret key"
}

variable "cluster_name" {
  type = string
}

variable "rke2_version" {
  type = string
}

variable "harvester_cloud_credential_id" {
  type = string
}
