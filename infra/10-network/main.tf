terraform {
  required_version = ">= 1.6.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.140.0"
    }
  }
}

provider "yandex" {
  zone = var.zone
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "folder_id" {
  type = string
}

resource "yandex_vpc_network" "main" {
  name = "vpc-cloud-security"
}

resource "yandex_vpc_subnet" "public" {
  name           = "subnet-public-cloud-security"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_vpc_subnet" "private" {
  name           = "subnet-private-cloud-security"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.20.0/24"]
}

resource "yandex_vpc_security_group" "sg_before_broad" {
  name       = "sg-before-broad-cloud-security"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "DEMO BEFORE: broad SSH access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "DEMO BEFORE: broad HTTP access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "sg_after_restricted" {
  name       = "sg-after-restricted-cloud-security"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "AFTER: HTTP only for demo app"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

output "network_id" {
  value = yandex_vpc_network.main.id
}

output "public_subnet_id" {
  value = yandex_vpc_subnet.public.id
}

output "private_subnet_id" {
  value = yandex_vpc_subnet.private.id
}

output "sg_before_broad_id" {
  value = yandex_vpc_security_group.sg_before_broad.id
}

output "sg_after_restricted_id" {
  value = yandex_vpc_security_group.sg_after_restricted.id
}
