resource "aws_s3_bucket" "cloudfront" {
  bucket = "kp.static-constents"
  acl    = "public-read"
}
