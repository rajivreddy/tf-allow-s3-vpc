
provider "aws" {
  version                 = "~> 2.14.0"
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
  profile                 = var.profile
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}
data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}
resource "aws_vpc_endpoint" "ep" {
  vpc_id       = var.vpc_id
  service_name = "${data.aws_vpc_endpoint_service.s3.service_name}"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.ep.id
  route_table_id  = var.route_id
}

data "template_file" "policy_josn" {
  template = "${file("./data.json")}"

  vars = {
    bucket_name = var.bucket_name
    vpce        = aws_vpc_endpoint.ep.id
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = "${aws_s3_bucket.bucket.id}"

  policy = data.template_file.policy_josn.rendered
}

