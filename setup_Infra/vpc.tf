
#    Take cidr_block = 126.0.0.0/16
#    public subnet 1 = 126.0.1.0/24
#    public subnet 2 = 126.0.2.0/24
#    aws_region = ap-south-1
#    avaibility zones :  ap-south-1a , ap-south-1b , ap-south-1c

# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
# This vpc will create main RT by default
resource "aws_vpc" "my_vpc" {
  cidr_block       = "126.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project1-vpc"
  }
}

# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "Public_subnet_az1" {
  depends_on = [ aws_vpc.my_vpc ]
  cidr_block        = var.pub_subnet1
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.availability_zones.az1
  map_public_ip_on_launch = true
  tags = {
    Name = " Public_subnet_az1 "
  }
}

resource "aws_subnet" "Public_subnet_az2" {
  depends_on = [ aws_vpc.my_vpc ]
  cidr_block        = var.pub_subnet2
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.availability_zones.az2
  map_public_ip_on_launch = true
  tags = {
    Name = " Public_subnet_az2 "
  }
}

## Subnet ##
# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
#       https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

# assigned multiple subnets to single routing table
resource "aws_route_table_association" "public_rt_association_project1" {
  for_each      = {
    "az1" = aws_subnet.Public_subnet_az1.id
    "az2" = aws_subnet.Public_subnet_az2.id
  }
  subnet_id      = each.value
  route_table_id = aws_vpc.my_vpc.main_route_table_id
}

# Create Internet Gateway and attach to vpc
# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "project1_igw" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "project1_igw"
  }
}

# Add route to the internet gateway for existing public route table
# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "public_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_vpc.my_vpc.main_route_table_id
  gateway_id             = aws_internet_gateway.project1_igw.id
}