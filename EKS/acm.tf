data "aws_route53_zone" "sandra_dns_zone" {
  name         = var.zone_name
  private_zone = false
}

module "sandra_acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = "${var.cluster_name}.${var.zone_name}"
  zone_id     = data.aws_route53_zone.sandra_dns_zone.zone_id

  subject_alternative_names = [
    "*.${var.cluster_name}.${var.zone_name}"
  ]

  wait_for_validation = true

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-acm"
    }
  )
}
