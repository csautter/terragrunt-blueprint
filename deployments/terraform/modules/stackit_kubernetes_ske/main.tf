resource "stackit_ske_cluster" "this" {
  project_id             = var.project_id
  name                   = substr(var.cluster_name, 0, 11)
  kubernetes_version_min = "1.30.6"
  node_pools             = var.node_pools
  maintenance = {
    enable_kubernetes_version_updates    = true
    enable_machine_image_version_updates = true
    start                                = "01:00:00Z"
    end                                  = "02:00:00Z"
  }

  extensions = {
    argus = {
      enabled           = var.observability_instance_id == "" ? false : true
      argus_instance_id = var.observability_instance_id
    }
  }
}

resource "stackit_ske_kubeconfig" "this" {
  project_id   = var.project_id
  cluster_name = stackit_ske_cluster.this.name
  refresh      = true
  expiration   = 3600 * 24 * 30 # 30 days
}

# write kubeconfig to file
resource "local_file" "kubeconfig" {
  content  = stackit_ske_kubeconfig.this.kube_config
  filename = "${path.module}/kubeconfig"
}