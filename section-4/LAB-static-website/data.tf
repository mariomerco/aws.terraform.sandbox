data "aws_route53_zone" "hosted_zone" {
  name = local.domain_name
}
