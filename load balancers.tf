resource "aws_iam_server_certificate" "rabbitmq_load_balancer_cert" {
  name             = "rabbitmq_load_balancer"
  certificate_body = file("rabbitmq_load_balancer.crt")
  private_key      = file("rabbitmq_load_balancer.key")
}

resource "aws_elb" "rabbitmq_elb" {
  name = "${local.cluster_name}-elb"

  listener {
    instance_port     = 5672
    instance_protocol = "tcp"
    lb_port           = 5672
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 15672
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 15672
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
    ssl_certificate_id = aws_iam_server_certificate.rabbitmq_load_balancer_cert.arn
  }

  health_check {
    interval            = 30
    unhealthy_threshold = 10
    healthy_threshold   = 2
    timeout             = 3
    target              = "TCP:5672"
  }

  subnets         = [aws_subnet.pub_subnet.id]
  idle_timeout    = 3600
  internal        = false
  security_groups = concat([aws_security_group.rabbitmq_elb.id], var.rabbitmq_elb_additional_security_group_ids)

  tags = {
    Name = local.cluster_name
  }
}
