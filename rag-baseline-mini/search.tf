# ============================================================
# AETHRONOPS v2 — SEARCH
# Pattern  : rag-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : SEARCH-SEARCHSERVICE
# Module AVM : Azure/avm-res-search-searchservice/azurerm
# Version    : ~> 0.2
# Azure AI Search est le moteur de recherche cognitif
# d'Azure. Il indexe et enrichit les documents avec
# des skillsets AI (NLP, OCR, embeddings).
# AethronOps configure :
# -> SKU adapte au tier (free/basic/standard)
# -> Network ACLs en standard/premium
# -> Managed Identity pour auth
# -> Diagnostic settings vers Log Analytics
# CAF : DATA-1, APP-2
# Ref : https://learn.microsoft.com/azure/search/search-what-is-azure-search
# MCSB : DP-1, DP-3, NS-3, IM-1
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-data-protection
# RGPD : ART-32, ART-25
# NIS2 : ART-21-2a, ART-21-2d
# ──────────────────────────────────────────────────────────
module "search_searchservice" {
  source  = "Azure/avm-res-search-searchservice/azurerm"
  version = "~> 0.2"

  name     = "srch-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  resource_group_name = module.resource_group.name

  sku                          = "free"
  public_network_access_enabled = true
  managed_identities = {
    system_assigned = true
  }

  tags             = local.common_tags
  enable_telemetry = false
}
