resource "aws_eks_node_group" "sandra_node_group" {
  cluster_name    = aws_eks_cluster.sandra.name
  node_group_name = "${var.cluster_name}-workers"
  node_role_arn   = aws_iam_role.sandra_node_role.arn
  subnet_ids      = [
    "subnet-04854c9f3de4fab00",
    "subnet-0b6b2bf1b5c983c9f",
    "subnet-0b130d891159e5fc6"
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.medium"]

  labels = {
    "node-type" : "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.sandra_worker_node_policy,
    aws_iam_role_policy_attachment.sandra_cni_policy,
    aws_iam_role_policy_attachment.sandra_ecr_readonly
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-workers"
    }
  )
}
