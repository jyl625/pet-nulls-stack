# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.7.2"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.4"
  }

  bufo = {
    source  = "austinvalle/bufo"
    version = "~> 2.1.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "bufo" "this" {}
provider "local" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
    bufo = provider.bufo.this
    local = provider.local.this
  }
}
