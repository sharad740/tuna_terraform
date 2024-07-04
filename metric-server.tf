resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
  }
}

resource "helm_release" "tuna-metrics" {
  name       = "tuna-metrics"
  chart      = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  version    = "3.12.1"  # Adjust the version as needed
  wait       = true
  namespace  = kubernetes_namespace.metrics.metadata[0].name
  cleanup_on_fail = "true"

  set {
    name  = "metrics.enabled"
    value = "true"
  }

}

