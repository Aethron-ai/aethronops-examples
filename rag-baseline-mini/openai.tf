# ============================================================
# AETHRONOPS v2 — OPENAI
# Pattern  : rag-baseline / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRICK : COGNITIVE-ACCOUNT
# Module AVM : Azure/avm-res-cognitiveservices-account/azurerm
# Version    : ~> 0.11
# Azure Cognitive Services / OpenAI is the managed AI service
# on Azure. It hosts GPT, DALL-E, Whisper models, and more.
# AethronOps configures:
# -> Kind OpenAI with SKU S0
# -> Custom subdomain for endpoint
# -> Network ACLs in standard/premium tier
# -> Managed Identity for auth
# -> Diagnostic settings to Log Analytics
# CAF : APP-2, DATA-1
# Ref : https://learn.microsoft.com/azure/ai-services/openai/overview
# MCSB : DP-1, DP-3, NS-3, IM-1
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-data-protection
# RGPD : ART-32, ART-25, ART-5
# NIS2 : ART-21-2a, ART-21-2d
# ──────────────────────────────────────────────────────────
module "cognitive_account" {
  source  = "Azure/avm-res-cognitiveservices-account/azurerm"
  version = "~> 0.11"

  name     = "oai-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  parent_id = module.resource_group.resource_id

  kind                          = "OpenAI"
  sku_name                      = "S0"
  custom_subdomain_name         = "oai-${var.project_name}-${var.environment}-${var.region_short}"
  public_network_access_enabled = true
  managed_identities = {
    user_assigned_resource_ids = [module.managed_identity.resource_id]
  }

  tags             = local.common_tags
  enable_telemetry = false
}
