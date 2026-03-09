# ============================================================
# AETHRONOPS v2 — VARIABLES
# ============================================================

variable "project_name" {
  description = "Nom du projet (minuscules, tirets uniquement)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name doit être en minuscules et tirets uniquement."
  }
}

variable "environment" {
  description = "Environnement cible"
  type        = string
  validation {
    condition     = contains(["dev", "uat", "test", "staging", "prod"], var.environment)
    error_message = "environment doit être dev, uat, test, staging ou prod."
  }
}

variable "location" {
  description = "Région Azure principale"
  type        = string
  default     = "westeurope"
}

variable "region_short" {
  description = "Code court de la région (ex: weu, frc)"
  type        = string
  default     = "weu"
}

variable "subscription_id" {
  description = "ID de la subscription Azure"
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
