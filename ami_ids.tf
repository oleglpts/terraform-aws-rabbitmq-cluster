data "aws_ami_ids" "rabbitmq_ami" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = [var.rabbitmq_ami]
  }
}
