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

variable "harvester_name" {
  type        = string
  description = "Harvester name"
}

variable "harvester_cloud_crenditial_name" {
  type        = string
  description = "Harvester cloud crenditial name"
}

variable "image_name" {
  type        = string
  description = "The cloud image node uses"
}

variable "rke2_version" {
  type        = string
  description = "RKE2 version"
}