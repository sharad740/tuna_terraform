resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "tuna-route"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.7.0"  # Adjust the version as needed
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  cleanup_on_fail = true
  timeout  = 200
  wait_for_jobs = false
  wait       = false

  set {
    name  = "controller.replicaCount"
    value = "2"
  }

  set {
    name = "controller.publishService.enabled"
    value = "true"
  }

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = "194.195.112.112"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "true"
  }
  set {
    name  = "controller.ingressClass.setAsDefaultIngress"
    value = "true"
  }
}

