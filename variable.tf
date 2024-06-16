
variable "s3_bucket" {
  default = "saan3"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "counts" {
  default = 6
}
variable "service_name" {
  type = string
  default = "com.amazonaws.ap-south-1.s3"
}