resource "aws_security_group" "sandra_eks_sg" {
  name        = "sandra-cluster-eks-sg"
  description = "Security Group for EKS cluster - sandra-cluster"
  vpc_id      = "vpc-0fe31270afbc347a8" 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS inbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Environment = "dev",
      Project     = "sandra"
    },
    {
      Name = "sandra-cluster-eks-sg"
    }
  )
}

data "http" "my_external_ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  my_workstation_cidr = "${chomp(data.http.my_external_ip.response_body)}/32"
}

resource "aws_security_group_rule" "sandra_api_access" {
  security_group_id = aws_security_group.sandra_eks_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [local.my_workstation_cidr]
  description       = "Allow my workstation to communicate with the cluster API Server"
}
