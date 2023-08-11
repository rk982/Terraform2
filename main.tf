
resource "aws_vpc" "simplylearn_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  

  tags = {
    Name = "simplylearn_vpc"
      }
  
}

resource "aws_subnet" "main_public_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.simplylearn_vpc.id}"
  map_public_ip_on_launch  = "true"
  availability_zone = "us-east-1a"
  
  tags = {
     
     Name = "main-public_1-Subnet",
}
}

resource "aws_subnet" "main_public_2" {
   cidr_block = "10.0.2.0/24"
   vpc_id = "${aws_vpc.simplylearn_vpc.id}"
   map_public_ip_on_launch = "true"
   availability_zone = "us-east-1b"  
     tags = {

      Name = "main-public_2-Subnet",
     }
}

resource "aws_subnet" "main_public_3" {
  cidr_block = "10.0.3.0/24"
  vpc_id = "${aws_vpc.simplylearn_vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1c"

   tags = {

    Name = "main-public_3-Subnet"

   }

}

resource "aws_subnet" "main_private_1" {
  cidr_block = "10.0.4.0/24"
  vpc_id = "${aws_vpc.simplylearn_vpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"
      tags = { 

        Name = "main-private_1-Subnet"  
      }
}

resource "aws_subnet" "main_private_2" {
   cidr_block = "10.0.5.0/24"
   vpc_id = "${aws_vpc.simplylearn_vpc.id}"  
   map_public_ip_on_launch = "false"
   availability_zone = "us-east-1b"
   
    tags = { 

      Name = "main_private_2-Subnet" 

    }

}

resource "aws_subnet" "main_private_3" {
  cidr_block = "10.0.6.0/24"
  vpc_id = "${aws_vpc.simplylearn_vpc.id}"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "false"
     tags = { 

      Name = "main_private_3-Subnet" 
     }
}

resource "aws_internet_gateway" "Simply_main_gw" {
    vpc_id = "${aws_vpc.simplylearn_vpc.id}"

    tags = { 

      Name = "main_gw"  
    }

}

resource "aws_route_table" "main_public_rt" {

    vpc_id = "${aws_vpc.simplylearn_vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.Simply_main_gw.id}"
    }
      tags = { 

        Name = "main_public_rt"

      }    
}

#Route table Association

resource "aws_route_table_association" "main_public_1" {
      subnet_id = "${aws_subnet.main_public_1.id}"
      route_table_id = "${aws_route_table.main_public_rt.id}"
      
}

resource "aws_route_table_association" "main_public_2" {
      subnet_id = "${aws_subnet.main_public_2.id}"
      route_table_id = "${aws_route_table.main_public_rt.id}"
  
}

resource "aws_route_table_association" "main_public_3" {

   subnet_id = "${aws_subnet.main_public_3.id}"
   route_table_id = "${aws_route_table.main_public_rt.id}"
  
}
