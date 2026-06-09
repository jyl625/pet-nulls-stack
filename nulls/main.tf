# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }

    bufo = {
      source  = "austinvalle/bufo"
      version = "2.1.0"
    }
    
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

variable "pet" {
  type = string
}

variable "instances" {
  type = number
}

variable "my_count" {
  type    = number
  default = 2
}

resource "null_resource" "resource_with_action_and_count" {
  count = 2
  lifecycle {
    action_trigger {
      events  = [after_create]
      actions = [action.bufo_print.success]
    }
  }
}

resource "null_resource" "executor" {
  provisioner "local-exec" {
    command = "echo 'Hello from Stacks component resource!'"
  }
}

locals {
  secret_name = sensitive("bufo-the-builder")
}

action "bufo_print" "success" {
  config {
    name = local.secret_name
  }
}

output "ids" {
  value = [for n in null_resource.this : n.id]
}
