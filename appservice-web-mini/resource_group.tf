# ============================================================
# AETHRONOPS v2 — RESOURCE GROUP
# Pattern  : appservice-web / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : RESOURCE-GROUP
# Module AVM : Azure/avm-res-resources-resourcegroup/azurerm
# Version    : ~> 0.1
# Le Resource Group est le conteneur logique de toutes tes
# ressources Azure. Il permet de les organiser, les gérer,
# les taguer et les facturer ensemble.
# AethronOps crée un RG par domaine fonctionnel
# (network, security, identity...) pour une gouvernance claire.
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
