variable "aws_region" {
  type = string
}

variable "availability_zones" {
  type = map(any)
}

variable "pub_subnet1" {
  type = string
}

variable "pub_subnet2" {
  type = string
}