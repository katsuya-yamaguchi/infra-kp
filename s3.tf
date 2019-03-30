resource "aws_s3_bucket" "cloudfront" {
  bucket = "static-contents"
  acl    = "pulic-read"
}
