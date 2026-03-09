# ============================================================
# AETHRONOPS v2 — OUTPUTS
# ============================================================

output "resource_group_id" {
  description = "ID du resource group principal"
  value       = module.resource_group.resource_id
}

output "key_vault_id" {
  description = "ID du Key Vault"
  value       = module.key_vault.resource_id
}

output "key_vault_uri" {
  description = "URI du Key Vault"
  value       = module.key_vault.uri
}

output "log_analytics_id" {
  description = "ID du Log Analytics Workspace"
  value       = module.log_analytics.resource_id
}

output "cognitive_account_id" {
  description = "Resource ID du Cognitive Account (OpenAI)"
  value       = module.cognitive_account.resource_id
}

output "search_service_id" {
  description = "Resource ID du Azure AI Search"
  value       = module.search_searchservice.resource_id
}
