resource "aws_eks_cluster" "sandra" {
  name     = "sandra-cluster"
  role_arn = aws_iam_role.sandra_eks_role.arn

  vpc_config {
    security_group_ids = [aws_security_group.sandra_eks_sg.id]
    subnet_ids = ["subnet-04854c9f3de4fab00", "subnet-0b6b2bf1b5c983c9f", "subnet-0b130d891159e5fc6"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.sandra_cluster_policy,
    aws_iam_role_policy_attachment.sandra_vpc_resource_controller
  ]

  tags = merge(
    {
      Environment = "dev",
      Project     = "sandra"
    },
    {
      Name = "sandra-cluster"
    }
  )
}

data "aws_eks_cluster_auth" "sandra_auth" {
  name = aws_eks_cluster.sandra.name
}

resource "aws_eks_addon" "sandra_coredns" {
  cluster_name                = "sandra-cluster"
  addon_name                  = "coredns"
  addon_version               = "v1.11.3-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_node_group.sandra_node_group]
}
