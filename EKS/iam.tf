resource "aws_iam_role" "sandra_eks_role" {
  name = "sandra-cluster-eks-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "eks.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(
    {
      Environment = "dev",
      Project     = "sandra"
    },
    { Name = "sandra-cluster-eks-role" }
  )
}

resource "aws_iam_role_policy_attachment" "sandra_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.sandra_eks_role.name
}

resource "aws_iam_role_policy_attachment" "sandra_vpc_resource_controller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.sandra_eks_role.name
}

data "tls_certificate" "sandra_eks_oidc_cert" {
  url = aws_eks_cluster.sandra.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "sandra_openid_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.sandra_eks_oidc_cert.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.sandra.identity[0].oidc[0].issuer
}

module "sandra_oidc_provider_data" {
  source     = "reegnz/oidc-provider-data/aws"
  version    = "0.0.3"
  issuer_url = aws_eks_cluster.sandra.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "sandra_node_role" {
  name = "sandra-cluster-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge(
    {
      Environment = "dev",
      Project     = "sandra"
    },
    { Name = "sandra-cluster-eks-node-role" }
  )
}

resource "aws_iam_policy" "sandra_secrets_policy" {
  name        = "GetSecretsForSandra"
  path        = "/"
  description = "Policy to read aws secrets for project Sandra"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Sid" : "AllowListHostedZones",
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sandra_secrets_policy_attachment" {
  policy_arn = aws_iam_policy.sandra_secrets_policy.arn
  role       = aws_iam_role.sandra_node_role.name
}

resource "aws_iam_role_policy_attachment" "sandra_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.sandra_node_role.name
}

resource "aws_iam_role_policy_attachment" "sandra_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.sandra_node_role.name
}

resource "aws_iam_role_policy_attachment" "sandra_ecr_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.sandra_node_role.name
}
