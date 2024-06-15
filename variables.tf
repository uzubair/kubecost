
variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "kubecost_version" {
  type        = string
  description = "Version of the kubecost"
  default     = "1.106.3"
}

variable "kubecost_namespace" {
  type        = string
  description = "The K8s namespace to deploy kubecost to."
  default     = "kubecost"
}

variable "kubecost_token" {
  type        = string
  description = "A token for kubecost, obtained from the kubecost organization"
  default     = ""
}

variable "enable_kubecost" {
  type        = bool
  description = "Enable kubecost"
  default     = true
}

variable "prometheus_url" {
  type        = string
  description = "External URL to Prometheus running on this cluster."
  default     = ""
}

variable "external_dns_managed_domain" {
  type        = string
  description = "Route53 domain that external-dns will add entries to"
}

variable "cluster_scoped_hostnames" {
  type        = bool
  description = "The cluster scoped hostnames"
  default     = false
}
