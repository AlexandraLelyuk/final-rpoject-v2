############################################################
# ARGO CD INSTALLATION
# Файл для установки ArgoCD через Helm.
############################################################

resource "helm_release" "sandra_argocd" {
  name             = "sandra-argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.51.6"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd.${var.cluster_name}.${var.zone_name}"
  }

  set {
    name  = "server.ingress.annotations.kubernetes.io/ingress.class"
    value = "nginx"
  }

  set {
    name  = "server.insecure"
    value = "true"
  }

  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"
  }

  depends_on = [
    helm_release.sandra_ingress_nginx,
    aws_eks_node_group.sandra_node_group
  ]
}

data "kubernetes_secret" "sandra_argocd_secret" {
  depends_on = [helm_release.sandra_argocd]
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}
