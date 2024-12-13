output "kubeconfig" {
  description = "The kubeconfig for the cluster"
  value       = stackit_ske_kubeconfig.this.kube_config
  sensitive   = true
}

output "kubeconfig_yaml" {
  description = "The kubeconfig for the cluster as YAML"
  value       = yamldecode(stackit_ske_kubeconfig.this.kube_config)
  sensitive   = true
}


output "cluster_endpoint" {
  description = "The host of the cluster"
  value       = yamldecode(nonsensitive(stackit_ske_kubeconfig.this.kube_config)).clusters[0].cluster.server
}

output "cluster_ca_certificate" {
  description = "The CA certificate of the cluster"
  value       = yamldecode(stackit_ske_kubeconfig.this.kube_config).clusters[0].cluster.certificate-authority-data
  sensitive   = true
}

output "client_key" {
  description = "The client key of the user"
  value       = yamldecode(stackit_ske_kubeconfig.this.kube_config).users[0].user.client-key-data
  sensitive   = true
}

output "client_certificate" {
  description = "The client certificate of the user"
  value       = yamldecode(stackit_ske_kubeconfig.this.kube_config).users[0].user.client-certificate-data
  sensitive   = true
}