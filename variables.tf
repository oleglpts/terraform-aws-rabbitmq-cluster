variable "region" {
  default = "eu-central-1"
}

variable "vpc_name" {
  default = "main"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_name" {
  default = "private subnet"
}

variable "private_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_name" {
  default = "public subnet"
}

variable "public_cidr_block" {
  default = "10.0.2.0/24"
}

variable "route_table_cidr_block" {
  default = "0.0.0.0/0"
}

variable "rabbitmq_cluster_name" {
  default = "main"
}

variable "rabbitmq_ami" {
  default = "amzn-ami-hvm-2017*-gp2"
}

variable "rabbitmq_zone_name" {
  default = "rabbitmq"
}

variable "rabbitmq_name" {
  default = "rabbit"
}

variable "rabbitmq_set_id" {
  default = "rabbit"
}

variable "rabbitmq_instance_type" {
  default = "t2.micro"
}

variable "rabbitmq_instance_volume_type" {
  default = "standard"
}

variable "rabbitmq_instance_volume_size" {
  default = "0"
}

variable "rabbitmq_instance_volume_iops" {
  default = "0"
}

variable "rabbitmq_nodes_additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "rabbitmq_elb_additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "rabbitmq_min_size" {
  description = "Minimum number of RabbitMQ nodes"
  default     = 2
}

variable "rabbitmq_desired_size" {
  description = "Desired number of RabbitMQ nodes"
  default     = 2
}

variable "rabbitmq_max_size" {
  description = "Maximum number of RabbitMQ nodes"
  default     = 2
}
