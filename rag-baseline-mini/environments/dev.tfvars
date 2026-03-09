# ============================================================
# AETHRONOPS v2 — TFVARS : DEV
# Tier effectif : basic
# ============================================================
#
# TODO: Adapt these values to your environment
#   1. Change project_name to your project identifier
#   2. Change subscription_id to your Azure subscription
#   3. Optionally adjust location and tags
#   4. Uncomment enterprise options below as needed
#
# Then run: terraform plan -var-file=environments/dev.tfvars
# ============================================================

project_name    = "myproject"      # TODO: Change to your project name
environment     = "dev"
location        = "westeurope"
region_short    = "weu"
subscription_id = "00000000-0000-0000-0000-000000000000"   # TODO: Change to your Azure subscription ID

tags = {
  owner = "your-team"
  project = "myproject"
  managed_by = "terraform"
}

# ────────────────────────────────────────────────────────────
# ENTERPRISE OPTIONS — Uncomment and adapt as needed
# ────────────────────────────────────────────────────────────

# custom_tags = {
#   cost_center         = "IT-1234"
#   business_unit       = "finance"
#   data_classification = "confidential"
#   owner_email         = "team@company.com"
# }

# require_private_endpoints = true    # Zero-trust: force private endpoints on all PaaS
# allowed_locations = ["westeurope", "francecentral"]  # Geo-fencing policy
# security_contact_email = "security@company.com"   # Alert notifications
