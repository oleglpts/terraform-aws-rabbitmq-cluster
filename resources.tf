resource "random_string" "rabbitmq_admin_password" {
  length  = 32
  special = false
}

resource "random_string" "rabbitmq_rabbit_password" {
  length  = 32
  special = false
}

resource "random_string" "rabbitmq_secret_cookie" {
  length  = 64
  special = false
}
