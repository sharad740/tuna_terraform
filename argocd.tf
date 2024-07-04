# Create namespace for Argo CD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Define Helm release for Argo CD
resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  cleanup_on_fail = true
  repository = "https://argoproj.github.io/argo-helm"
  version    = "7.3.4"
  wait       = true
  wait_for_jobs = false
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  values = [file("${path.module}/argocd/values.yaml")]  # Use custom values.yaml
}
