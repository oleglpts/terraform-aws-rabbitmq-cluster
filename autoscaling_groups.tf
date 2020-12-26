resource "aws_autoscaling_group" "rabbitmq" {
  name                      = local.cluster_name
  min_size                  = var.rabbitmq_min_size
  desired_capacity          = var.rabbitmq_desired_size
  max_size                  = var.rabbitmq_max_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.rabbitmq.name
  load_balancers            = [aws_elb.rabbitmq_elb.name]
  vpc_zone_identifier       = [aws_subnet.pub_subnet.id]

  tag {
    key                 = "Name"
    value               = local.cluster_name
    propagate_at_launch = true
  }
}
