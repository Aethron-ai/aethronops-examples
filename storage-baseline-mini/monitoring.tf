# ============================================================
# AETHRONOPS v2 — MONITORING
# Pattern  : storage-baseline / mini
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
