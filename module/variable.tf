variable "public_sub_cidr_block" {
    default = "10.0.1.0/24"
  type = string
}

variable "private_sub_cidr_block" {
    default = "10.0.0.0/24"
  type = string
}

variable "vpc_name" {
  type = string
}
variable "subnet_name" {
  type = string
}