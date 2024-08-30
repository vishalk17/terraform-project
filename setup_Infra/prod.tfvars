environment   = "production-high-capacity"
high_capacity = "t2.micro" // for production-high-capacity environment. if not this then t2.small will be default
aws_region    = "ap-south-1"
availability_zones = {
  az1 = "ap-south-1a"
  az2 = "ap-south-1b"
  az3 = "ap-south-1c"
}

pub_subnet1 = "126.0.1.0/24"
pub_subnet2 = "126.0.2.0/24"

ingress_ports = [80, 443, 22]
