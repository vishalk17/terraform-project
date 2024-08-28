
#    Take cidr_block = 126.0.0.0/16
#    public subnet 1 = 126.0.1.0/24
#    public subnet 2 = 126.0.2.0/24
#    aws_region = ap-south-1
#    avaibility zones :  ap-south-1a , ap-south-1b , ap-south-1c

# ref : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
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