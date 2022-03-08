variable "ssh_keypair" {
description = "SSH keypair/EC2"
default = null
type = string
}

variable "region" {
description = "AWS region"
default = "eu-west-1"
type = string
}