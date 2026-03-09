# ============================================================
# AETHRONOPS v2 — MONITORING
# Pattern  : appservice-web / mini
# Tier     : basic
# ============================================================
# DO NOT EDIT MANUALLY — Regenerate via AethronOps
# ============================================================

# ──────────────────────────────────────────────────────────
# BRICK : LOG-ANALYTICS
# Module AVM : Azure/avm-res-operationalinsights-workspace/azurerm
# Version    : ~> 0.4
# Log Analytics is the central hub for all logs and
# metrics of your Azure infrastructure.
# All other resources send their diagnostics here.
# Without centralized logs, you are blind during incidents:
# you cannot tell what happened, when, and who.
# This is also the foundation for all alerts and dashboards.
# CAF : OPS-1, OPS-2, GOV-3
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/manage/monitor
# MCSB : LT-1, LT-2, LT-3, LT-4, LT-5, IR-1
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-logging-threat-detection
# RGPD : ART-30, ART-32, ART-33
# NIS2 : ART-21-2b, ART-21-2f
# ──────────────────────────────────────────────────────────
module "log_analytics" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "~> 0.4"

  name     = "log-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  resource_group_name = module.resource_group.name

  log_analytics_workspace_sku               = "PerGB2018"
  log_analytics_workspace_retention_in_days = 30

  tags             = local.common_tags
  enable_telemetry = false
}

# ──────────────────────────────────────────────────────────
# BRICK : APPLICATION-INSIGHTS
# Module AVM : Azure/avm-res-insights-component/azurerm
# Version    : 0.3.0
# Application Insights is Azure.s APM solution. It automatically
# collects traces, metrics, exceptions, and dependencies.
# CAF : OPS-1, OPS-2
# Ref : https://learn.microsoft.com/azure/cloud-adoption-framework/manage/monitor/app-insights
# MCSB : LT-1, LT-3, LT-4, IR-1, IR-3
# Ref : https://learn.microsoft.com/security/benchmark/azure/mcsb-logging-threat-detection
# RGPD : ART-32, ART-33
# NIS2 : ART-21-2a, ART-23
# ──────────────────────────────────────────────────────────
module "application_insights" {
  source  = "Azure/avm-res-insights-component/azurerm"
  version = "0.3.0"

  name     = "appi-${var.project_name}-${var.environment}-${var.region_short}"
  location = var.location
  resource_group_name = module.resource_group.name

  workspace_id        = module.log_analytics.resource_id
  application_type    = "web"
  retention_in_days   = 30
  sampling_percentage = 100

  tags             = local.common_tags
  enable_telemetry = false
}
