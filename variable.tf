variable "shared_credentials_file" {
  description = "Path of aws creds"
  type        = string
  default     = ""
}
variable "profile" {
  description = "aws profile name"
  type        = string
  default     = "default"
}

variable "region" {
  description = "Region where you want to create s3"
  type        = string
  default     = "us-west-2"
}
variable "bucket_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  description = "VPC id "
  type        = string
  default     = ""
}

variable "route_id" {
  description = "Route table id, from where you want to access s3"
  default     = ""
}
