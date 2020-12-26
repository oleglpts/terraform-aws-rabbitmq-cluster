resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags                 = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_cidr_block
    tags                    = {
        Name = var.private_subnet_name
    }
    depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "pub_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.public_cidr_block
    map_public_ip_on_launch = true
    tags                    = {
        Name = var.public_subnet_name
    }
    depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags   = {
        Name = "${var.public_subnet_name} internet gateway"
    }
    depends_on = [aws_vpc.vpc]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.route_table_cidr_block
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
  tags = {
    Name = "${var.public_subnet_name} route table"
  }
}

resource "aws_route_table_association" "route_table_association" {
    subnet_id      = aws_subnet.pub_subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route53_zone" "rabbit_load_balancer" {
  name = var.rabbitmq_zone_name
  vpc {
    vpc_id = aws_vpc.vpc.id
  }
  tags = {
    Name = "rabbitmq load balancer zone"
  }
}

resource "aws_route53_record" "rabbitmq_ns_record" {
  zone_id = aws_route53_zone.rabbit_load_balancer.zone_id
  name    = var.rabbitmq_name
  type    = "CNAME"
  ttl     = "5"
  weighted_routing_policy {
    weight = 10
  }
  set_identifier = var.rabbitmq_set_id
  records = [aws_elb.rabbitmq_elb.dns_name]
}
