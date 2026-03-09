# ============================================================
# AETHRONOPS v2 — KEYVAULT
# Pattern  : storage-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRICK : KEY-VAULT
# Module AVM : Azure/avm-res-keyvault-vault/azurerm
# Version    : ~> 0.9
# Azure Key Vault is the centralized vault for all
# your secrets, encryption keys, and certificates.
# Your apps retrieve secrets at runtime via
# their Managed Identity — never stored in code.
# All operations are logged and auditable.
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
