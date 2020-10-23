resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.awsenv
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1
  availability_zone_id = "use1-az1"
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.awsenv
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2
  availability_zone_id = "use1-az2"
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.awsenv
  }
}

resource "aws_subnet" "subnet1-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1-private
  availability_zone_id = "use1-az1"
  map_public_ip_on_launch = "false"

  tags = {
    Name = var.awsenv
  }
}

resource "aws_subnet" "subnet2-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2-private
  availability_zone_id = "use1-az2"
  map_public_ip_on_launch = "false"

  tags = {
    Name = var.awsenv
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.awsenv
  }
}

resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = var.public_cidr
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
	Name = var.awsenv
    }
}

resource "aws_route_table_association" "main-public-subnet1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-subnet2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_security_group_rule" "defaultsg1" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.public_cidr]
  security_group_id = aws_vpc.main.default_security_group_id
}

resource "aws_security_group_rule" "defaultsg2" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.public_cidr]
  security_group_id = aws_vpc.main.default_security_group_id
}

resource "aws_security_group_rule" "defaultsg4" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = [var.public_cidr]
  security_group_id = aws_vpc.main.default_security_group_id
}


resource "aws_security_group_rule" "defaultsg3" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.public_cidr]
  security_group_id = aws_vpc.main.default_security_group_id
}

resource "aws_security_group_rule" "defaultsg5" {
  type              = "ingress"
  from_port         = 11211
  to_port           = 11211
  protocol          = "tcp"
  cidr_blocks       = [var.public_cidr]
  security_group_id = aws_vpc.main.default_security_group_id
}


resource "aws_route_table" "main-private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = var.public_cidr
        nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }
    tags = {
	Name = var.awsenv
   }
   depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table_association" "main-private-subnet1" {
    subnet_id = aws_subnet.subnet1-private.id
    route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-subnet2" {
    subnet_id = aws_subnet.subnet2-private.id
    route_table_id = aws_route_table.main-private.id
}


resource "aws_eip" "nat-gateway-ip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway-ip.id
  subnet_id = aws_subnet.subnet1.id  
  tags = {
    Name = var.awsenv
  }
  depends_on = [aws_internet_gateway.gw]
}

