# ============================================================
# AETHRONOPS v2 — KEYVAULT
# Pattern  : appservice-web / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : KEY-VAULT
# Module AVM : Azure/avm-res-keyvault-vault/azurerm
# Version    : ~> 0.9
# Azure Key Vault est le coffre-fort centralisé pour tous
# tes secrets, clés de chiffrement et certificats.
# Tes apps récupèrent leurs secrets à l'exécution via
# leur Managed Identity — jamais stockés dans le code.
# Toutes les opérations sont loguées et auditables.
# CAF : SEC-3, SEC-4
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
# MCSB : DP-1, DP-2, DP-3, DP-6, DP-7
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-data-protection
# RGPD : ART-32
# NIS2 : ART-21-2h
# ──────────────────────────────────────────────────────────
module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "~> 0.9"

  name     = "kv-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  resource_group_name = module.resource_group.name

  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  public_network_access_enabled = true

  tags             = local.common_tags
  enable_telemetry = false
}
