resource "aws_iam_instance_profile" "rabbitmq" {
  name_prefix = local.cluster_name
  role        = aws_iam_role.rabbitmq_role.name
}

resource "aws_launch_configuration" "rabbitmq" {
  name                 = local.cluster_name
  image_id             = data.aws_ami_ids.rabbitmq_ami.ids[0]
  instance_type        = var.rabbitmq_instance_type
  key_name             = aws_key_pair.rabbitmq.key_name
  security_groups      = concat([aws_security_group.rabbitmq_nodes.id],
                                var.rabbitmq_nodes_additional_security_group_ids)
  iam_instance_profile = aws_iam_instance_profile.rabbitmq.id
  user_data            = data.template_file.rabbitmq-init.rendered

  root_block_device {
    volume_type           = var.rabbitmq_instance_volume_type
    volume_size           = var.rabbitmq_instance_volume_size
    iops                  = var.rabbitmq_instance_volume_iops
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
