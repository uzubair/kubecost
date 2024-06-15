<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alert_manager_cert"></a> [alert\_manager\_cert](#module\_alert\_manager\_cert) | gitlab.com/miovision/public-ssl-certificate/aws | 2.0.2 |
| <a name="module_grafana_cert"></a> [grafana\_cert](#module\_grafana\_cert) | gitlab.com/miovision/public-ssl-certificate/aws | 2.0.2 |
| <a name="module_prometheus_cert"></a> [prometheus\_cert](#module\_prometheus\_cert) | gitlab.com/miovision/public-ssl-certificate/aws | 2.0.2 |

## Resources

| Name | Type |
|------|------|
| [helm_release.kube-prometheus-stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.alertmanager_config_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.alertmanager_ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.csb_alerts_slack_webhook_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.datadog_metrics](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.grafana_ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.grafana_oauth_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.grafana_opsgenie_credentials_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.promtheus_ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_cluster_scoped_hostnames"></a> [cluster\_scoped\_hostnames](#input\_cluster\_scoped\_hostnames) | The cluster scoped hostnames | `bool` | `false` | no |
| <a name="input_create_grafana_opsgenie_secret"></a> [create\_grafana\_opsgenie\_secret](#input\_create\_grafana\_opsgenie\_secret) | Create additional OpsGenie secret for Grafana | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment | `string` | n/a | yes |
| <a name="input_external_dns_managed_domain"></a> [external\_dns\_managed\_domain](#input\_external\_dns\_managed\_domain) | Route53 domain that external-dns will add entries to | `string` | n/a | yes |
| <a name="input_grafana_config"></a> [grafana\_config](#input\_grafana\_config) | n/a | <pre>object({<br>    image_tag = string<br>    sidecar = object({<br>      image_tag = optional(string, null)<br>      alerts = object({<br>        enabled         = bool<br>        searchNamespace = string<br>      })<br>      dashboards = object({<br>        enabled         = bool<br>        searchNamespace = string<br>      })<br>      datasources = object({<br>        enabled         = bool<br>        searchNamespace = string<br>      })<br>      plugins = object({<br>        enabled         = bool<br>        searchNamespace = string<br>      })<br>      notifiers = object({<br>        enabled         = bool<br>        searchNamespace = string<br>      })<br>    })<br>  })</pre> | <pre>{<br>  "image_tag": "9.5.14",<br>  "sidecar": {<br>    "alerts": {<br>      "enabled": true,<br>      "searchNamespace": "ALL"<br>    },<br>    "dashboards": {<br>      "enabled": true,<br>      "searchNamespace": "ALL"<br>    },<br>    "datasources": {<br>      "enabled": true,<br>      "searchNamespace": "ALL"<br>    },<br>    "image_tag": "1.25.2",<br>    "notifiers": {<br>      "enabled": true,<br>      "searchNamespace": "ALL"<br>    },<br>    "plugins": {<br>      "enabled": true,<br>      "searchNamespace": "ALL"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_kube_namespace"></a> [kube\_namespace](#input\_kube\_namespace) | The K8s namespace to deploy kube prometheus stack into | `string` | `"coresystems"` | no |
| <a name="input_kube_prometheus_stack_version"></a> [kube\_prometheus\_stack\_version](#input\_kube\_prometheus\_stack\_version) | Kube Prometheus Stack version | `string` | `"51.2.0"` | no |
| <a name="input_secret_manager_path"></a> [secret\_manager\_path](#input\_secret\_manager\_path) | The path to the secret manager | `string` | n/a | yes |

## Kube Prometheus Stack: AdditionalScrapeConfig

Please add the following `additionalScrapeConfig` for Prometheus:
```
prometheus.prometheusSpec.additionalScrapeConfig:
    - job_name: kubecost-networking
      kubernetes_sd_configs:
        - role: pod
      relable_configs:
        # Scapre only the targets matching the following metadata
        - source_labels: [__meta_kubernetes_pod_label_app]
        - action: keep
        - regex: kubecost-network-costs
```

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alert_manager_ssl_cert_arn"></a> [alert\_manager\_ssl\_cert\_arn](#output\_alert\_manager\_ssl\_cert\_arn) | n/a |
| <a name="output_grafana_ssl_cert_arn"></a> [grafana\_ssl\_cert\_arn](#output\_grafana\_ssl\_cert\_arn) | n/a |
| <a name="output_helm_values"></a> [helm\_values](#output\_helm\_values) | n/a |
| <a name="output_prometheus_ssl_cert_arn"></a> [prometheus\_ssl\_cert\_arn](#output\_prometheus\_ssl\_cert\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
