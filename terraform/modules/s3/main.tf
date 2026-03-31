resource "aws_s3_bucket" "app" {
  bucket = "${var.project_name}-app-files"
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket                  = aws_s3_bucket.app.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "server_js" {
  bucket = aws_s3_bucket.app.id
  key    = "app/server.js"
  source = "${path.root}/../app/server.js"
  etag   = filemd5("${path.root}/../app/server.js")
}

resource "aws_s3_object" "package_json" {
  bucket = aws_s3_bucket.app.id
  key    = "app/package.json"
  source = "${path.root}/../app/package.json"
  etag   = filemd5("${path.root}/../app/package.json")
}
