module "sandra_external_dns" {
  source                           = "lablabs/eks-external-dns/aws"
  version                          = "1.2.0"
  
  cluster_identity_oidc_issuer     = aws_eks_cluster.sandra.identity[0].oidc[0].issuer
  cluster_identity_oidc_issuer_arn = module.sandra_oidc_provider_data.arn
}