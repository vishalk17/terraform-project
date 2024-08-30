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

variable "ingress_ports" {
  type = list(number)
}

variable "environment" {
  type        = string
  description = "High or Low Workload"
}

variable "high_capacity" {
  type = string
}