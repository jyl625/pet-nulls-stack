# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 3
  count = 0
  lifecycle {
    action_trigger {
      events  = [after_create]
      actions = [action.bufo_print.yay]
    }
  }
}

action "bufo_print" "yay" {
  config {
    name = "bufo-the-builder"
  }
}

output "name" {
  value = random_pet.this.id
}
