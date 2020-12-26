#
# Used https://github.com/ulamlabs/terraform-aws-rabbitmq
#

locals {
  cluster_name = "rabbitmq-${var.rabbitmq_cluster_name}"
}

data "template_file" "rabbitmq-init" {
  template = file("${path.module}/rabbitmq-init.yaml")

  vars = {
    sync_node_count = 3
    asg_name        = local.cluster_name
    region          = data.aws_region.current.name
    admin_password  = random_string.rabbitmq_admin_password.result
    rabbit_password = random_string.rabbitmq_rabbit_password.result
    secret_cookie   = random_string.rabbitmq_secret_cookie.result
    message_timeout = 3 * 24 * 60 * 60 * 1000 # 3 days
  }
}
