provider "aws" {
  region  = var.region
  profile = var.iam_profile
}

provider "kubernetes" {
  host                   = aws_eks_cluster.sandra.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.sandra.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.sandra_auth.token
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.sandra.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.sandra.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.sandra_auth.token
  }
}
