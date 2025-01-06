resource "helm_release" "sandra_metrics_server" {
  depends_on       = [aws_eks_node_group.sandra_node_group]
  name             = "sandra-metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server"
  chart            = "metrics-server"
  version          = "3.12.1"
  namespace        = "kube-system"
  create_namespace = true

}