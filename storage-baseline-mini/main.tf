# ============================================================
# AETHRONOPS v2 — GENERATED TERRAFORM
# Pattern  : storage-baseline / mini
# Tier     : basic
# Generated: auto
# ============================================================
# DO NOT EDIT MANUALLY
# Regenerate via AethronOps if changes needed
# ============================================================

terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azapi" {}

provider "random" {}

resource "random_string" "storage_suffix" {
  length  = 4
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}

locals {
  # Naming CAF — utilisé dans resource_group_name des modules
  rg_name = "rg-${var.project_name}-${var.environment}-${var.region_short}"

  # Common tags merged with business + enterprise tags
  common_tags = merge(var.tags, var.custom_tags, {
    environment = var.environment
    managed_by  = "aethronops"
    pattern     = "storage-baseline-mini"
  })
}
