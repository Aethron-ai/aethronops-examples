# ============================================================
# AETHRONOPS v2 — VARIABLES
# ============================================================

variable "project_name" {
  description = "Project name (lowercase and hyphens only)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must be lowercase letters, numbers, and hyphens only."
  }
}

variable "environment" {
  description = "Target environment"
  type        = string
  validation {
    condition     = contains(["dev", "uat", "test", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, uat, test, staging, prod."
  }
}

variable "location" {
  description = "Primary Azure region"
  type        = string
  default     = "westeurope"
}

variable "region_short" {
  description = "Short region code (e.g. weu, frc)"
  type        = string
  default     = "weu"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Business tags applied to all resources"
  type        = map(string)
  default     = {}
}

# ──────────────────────────────────────────────────────────
# ENTERPRISE CUSTOMIZATION
# Adapt these variables to match your organization policies.
# ──────────────────────────────────────────────────────────

variable "custom_tags" {
  description = "Enterprise-mandated tags (cost center, business unit, data classification...)"
  type        = map(string)
  default     = {}
  # Example: { cost_center = "IT-1234", business_unit = "finance", data_classification = "confidential" }
}

variable "require_private_endpoints" {
  description = "Force private endpoints on all PaaS services (enterprise zero-trust)"
  type        = bool
  default     = false
}

variable "allowed_locations" {
  description = "Allowed Azure regions (enterprise geo-fencing policy)"
  type        = list(string)
  default     = ["westeurope", "francecentral"]
}

variable "security_contact_email" {
  description = "Security team email for alerts and notifications"
  type        = string
  default     = ""
}
