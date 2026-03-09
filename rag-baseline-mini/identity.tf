# ============================================================
# AETHRONOPS v2 — IDENTITY
# Pattern  : rag-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : MANAGED-IDENTITY
# Module AVM : Azure/avm-res-managedidentity-userassignedidentity/azurerm
# Version    : ~> 0.3
# La Managed Identity est une identité Azure AD gérée
# automatiquement par Azure pour tes ressources.
# Tes apps et services peuvent s'authentifier à d'autres
# services Azure (Key Vault, Storage, BDD) SANS stocker
# de mot de passe ou de clé d'API dans le code.
# CAF : ID-1, ID-2
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/identity-access-management
# MCSB : IM-1, IM-2
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-identity-management
# RGPD : ART-25, ART-32
# NIS2 : ART-21-2i
# ──────────────────────────────────────────────────────────
module "managed_identity" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "~> 0.3"

  name     = "id-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  resource_group_name = module.resource_group.name

  tags             = local.common_tags
  enable_telemetry = false
}
