# ============================================================
# AETHRONOPS v2 — RESOURCE GROUP
# Pattern  : rag-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRICK : RESOURCE-GROUP
# Module AVM : Azure/avm-res-resources-resourcegroup/azurerm
# Version    : ~> 0.1
# The Resource Group is the logical container for all your
# Azure resources. It enables organizing, managing,
# tagging, and billing them together.
# AethronOps creates one RG per functional domain
# (network, security, identity...) for clear governance.
# CAF : RG-1, RG-2, GOV-1
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
# ──────────────────────────────────────────────────────────
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"

  name     = "rg-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location

  tags             = local.common_tags
  enable_telemetry = false
}
