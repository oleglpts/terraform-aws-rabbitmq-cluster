resource "aws_security_group" "rabbitmq_elb" {
  name        = "rabbitmq_elb-${var.rabbitmq_cluster_name}"
  vpc_id      = aws_vpc.vpc.id    # var.vpc_id
  description = "Security Group for the rabbitmq elb"

  ingress {
    protocol        = "tcp"
    from_port       = 5672
    to_port         = 5672
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rabbitmq ${var.rabbitmq_cluster_name} ELB"
  }
}

resource "aws_security_group" "rabbitmq_nodes" {
  name        = "${local.cluster_name}-nodes"
  vpc_id      = aws_vpc.vpc.id     #var.vpc_id
  description = "Security Group for the rabbitmq nodes"

  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 4369
    to_port         = 4369
    protocol        = "tcp"
    cidr_blocks     = [aws_subnet.pub_subnet.cidr_block]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 5672
    to_port         = 5672
    cidr_blocks = [aws_subnet.pub_subnet.cidr_block]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 15672
    to_port         = 15672
    cidr_blocks = [aws_subnet.pub_subnet.cidr_block]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 25672
    to_port         = 25672
    cidr_blocks = [aws_subnet.pub_subnet.cidr_block]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    Name = "rabbitmq ${var.rabbitmq_cluster_name} nodes"
  }
}
