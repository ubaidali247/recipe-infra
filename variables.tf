variable "resource_group_name" {
  default = "recipe-app-rg"
}

variable "location" {
  default = "northeurope"
}

variable "acr_name" {
  default = "recipeacr247"
}

variable "aks_cluster_name" {
  default = "recipe-aks"
}

variable "node_count" {
  default = 2
}