output "rabbitmq_elb_dns" {
  value = aws_elb.rabbitmq_elb.dns_name
}

output "rabbitmq_admin_password" {
  value     = random_string.rabbitmq_admin_password.result
  sensitive = false
}

output "rabbitmq_rabbit_password" {
  value     = random_string.rabbitmq_rabbit_password.result
  sensitive = false
}

output "rabbitmq_secret_cookie" {
  value     = random_string.rabbitmq_secret_cookie.result
  sensitive = false
}
