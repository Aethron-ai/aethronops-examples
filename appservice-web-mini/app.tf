# ============================================================
# AETHRONOPS v2 — APP
# Pattern  : appservice-web / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRIQUE : APP-SERVICE-PLAN
# Ressource  : azurerm_service_plan (native azurerm)
# L'App Service Plan définit la capacité de calcul (CPU/RAM)
# et le SKU de ton application web.
# Déployé comme ressource native azurerm car il n'existe pas
# de module AVM officiel dédié à ce jour.
# Le SKU est automatiquement adapté au tier choisi :
# B1 (dev/basic) → P1v3 (standard) → P3v3 (premium)
# CAF : APP-1
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/app-service-environment
# NIS2 : ART-21-2b
# ──────────────────────────────────────────────────────────
resource "azurerm_service_plan" "app_service_plan" {
  name                = "asp-${var.project_name}-${var.environment}-${var.region_short}"
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"

  tags = local.common_tags
}

# ──────────────────────────────────────────────────────────
# BRIQUE : APP-SERVICE
# Module AVM : Azure/avm-res-web-site/azurerm
# Version    : 0.21.0
# Azure App Service est la plateforme PaaS pour les applications web.
# Elle élimine la gestion des VMs, des OS et des patchs.
# Déploiement continu, scaling auto, intégration VNet, identité managée.
# CAF : APP-1, SEC-3
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/app-service-environment
# MCSB : NS-1, IM-1, DP-3, DS-6
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-identity-management
# RGPD : ART-32, ART-25
# NIS2 : ART-21-2b, ART-21-2h
# ──────────────────────────────────────────────────────────
module "app_service" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.21.0"

  name     = "app-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  parent_id = module.resource_group.resource_id

  kind                     = "webapp"
  service_plan_resource_id = azurerm_service_plan.app_service_plan.id
  https_only               = true
  site_config = {
    always_on           = false
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"
    http2_enabled       = true
  }
  managed_identities = {
    system_assigned = true
    user_assigned_resource_ids = [module.managed_identity.resource_id]
  }
  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.application_insights.resource_id
    AZURE_CLIENT_ID = module.managed_identity.client_id
  }

  tags             = local.common_tags
  enable_telemetry = false
}
