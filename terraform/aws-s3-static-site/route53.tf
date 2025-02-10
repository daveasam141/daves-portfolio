
####################################################
# # Create an A record in the hosted zone
####################################################

resource "aws_route53_record" "emagetech" {
  zone_id = var.zone_id
  name    = var.bucket_name
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.static_site_bucket_website_config.website_endpoint
    zone_id                = var.zone_id
    evaluate_target_health = false
  }

  depends_on = [
    aws_s3_bucket.static_website
  ]
}

