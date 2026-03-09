# ============================================================
# AETHRONOPS v2 — STORAGE
# Pattern  : storage-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : STORAGE-ACCOUNT
# Module AVM : Azure/avm-res-storage-storageaccount/azurerm
# Version    : ~> 0.2
# Le compte de stockage Azure fournit un stockage objet
# (Blob), fichier (File Share), table et queue.
# AethronOps configure automatiquement :
# → Chiffrement at-rest avec clés managées
# → HTTPS uniquement (TLS 1.2 minimum)
# → Accès réseau privé uniquement (Private Endpoint)
# → Versioning et soft-delete pour la récupération
# CAF : DATA-1
# MCSB : DP-1, DP-3, NS-3, AM-2
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-data-protection
# RGPD : ART-32, ART-5
# NIS2 : ART-21-2h
# ──────────────────────────────────────────────────────────
module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "~> 0.2"

  name     = "st${replace(var.project_name, "-", "")}${var.environment}${var.region_short}${random_string.storage_suffix.result}"
  location = var.location
  resource_group_name = module.resource_group.name

  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  shared_access_key_enabled     = true
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
  blob_properties = {
    versioning_enabled = false
    delete_retention_policy = {
      days = 7
    }
  }

  tags             = local.common_tags
  enable_telemetry = false
}
