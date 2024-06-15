
locals {
  kubecost_repo = "https://kubecost.github.io/cost-analyzer"
  kubecost_values = [
    templatefile("${path.module}/values.tmpl.yaml", {
      cluster_name   = var.cluster_name
      kubecost_token = var.kubecost_token
      prometheus_url = var.prometheus_url
      }
  )]
  basename          = var.external_dns_managed_domain
  hostname_stem     = var.cluster_scoped_hostnames ? "${var.cluster_name}.${var.external_dns_managed_domain}" : var.external_dns_managed_domain
  kubecost_hostname = "kubecost.${local.hostname_stem}"
}

resource "kubernetes_namespace" "kubecost_namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.kubecost_namespace
  }
}

resource "kubectl_manifest" "kubecost_ingress" {
  yaml_body = templatefile("${path.module}/templates/ingresses/kubecost-ingress.tmpl.yaml", {
    environment     = var.environment
    hostname_stem   = local.hostname_stem
    certificate_arn = module.kubecost_cert.cert.arn
  })

  depends_on = [
    helm_release.kubecost,
    module.kubecost_cert
  ]
}

resource "kubectl_manifest" "kubecost_metrics" {
  yaml_body = templatefile("${path.module}/templates/monitoring/kubecost-monitoring.tmpl.yaml", {
    kubecost_namespace = var.kubecost_namespace
  })

  depends_on = [
    helm_release.kubecost
  ]
}

resource "helm_release" "kubecost" {
  count      = var.enable_kubecost ? 1 : 0
  name       = "kubecost"
  namespace  = var.kubecost_namespace
  version    = var.kubecost_version
  repository = local.kubecost_repo
  chart      = "cost-analyzer"

  values = local.kubecost_values

  depends_on = [kubernetes_namespace.kubecost_namespace]
}

module "kubecost_cert" {
  source      = "gitlab.com/miovision/public-ssl-certificate/aws"
  version     = "2.0.2"
  hostname    = local.kubecost_hostname
  base_domain = local.basename
  tags = {
    Name = "SSL Certificate for kubecost"
  }
}

output "kubecost_ssl_cert_arn" {
  value = module.kubecost_cert.cert.arn
}
