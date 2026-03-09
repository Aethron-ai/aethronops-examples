# Compliance Matrix — rag-baseline

> AethronOps compliance report for pattern **rag-baseline** (mini, tier basic).

> **Important disclaimer**: This document maps the technical security controls implemented in the
> Terraform code to recognized compliance frameworks. It is an **aid for audit preparation**, not
> a certification. Regulatory compliance (PCI-DSS, HDS, DORA, etc.) requires a formal audit by
> an accredited assessor. AethronOps provides the technical foundation — your organization must
> complete the organizational, procedural, and human aspects of compliance.

---

## Security Controls Implemented

These controls are **verifiable directly in the Terraform code**:

| Control | Implementation | Scope | Evidence (file) |
|---------|---------------|-------|-----------------|
| Encryption at rest | AES-256 via Azure platform | All services | All .tf files |
| Encryption in transit | TLS 1.2 minimum enforced | All services | All .tf files |
| Zero secrets | Managed Identity (no API keys/passwords stored) | Authentication | identity.tf |
| Secret management | Azure Key Vault with RBAC access policies | Secrets & certificates | keyvault.tf |
| Centralized logging | Log Analytics Workspace — audit trail, diagnostics, alerts | Monitoring | monitoring.tf |
| IaC security scan | Checkov — automated security analysis, 0 failed checks | DevSecOps | .checkov.yaml |
| Module provenance | Azure Verified Modules (AVM) — Microsoft-maintained, versioned | Supply chain | SOURCES.md |
| Naming convention | CAF naming standard — consistent, auditable | Governance | All .tf files |
| Tagging policy | Mandatory tags: environment, managed_by, project | Governance | main.tf |
| Telemetry disabled | `enable_telemetry = false` on all AVM modules | Privacy | All modules |

> Firewall, Bastion, Private Endpoints, and Backup are **disabled** in tier basic (dev) to minimize costs. Enable them by deploying with tier standard or premium.

---

## Compliance Framework Mapping

| Framework | Controls Covered | Reference |
|-----------|-----------------|-----------|
| **CAF** (Cloud Adoption Framework) | APP-2, DATA-1, GOV-1, GOV-3, ID-1, ID-2, OPS-1, OPS-2, RG-1, RG-2, SEC-3, SEC-4 | [Microsoft CAF](https://learn.microsoft.com/azure/cloud-adoption-framework/) |
| **MCSB** (Microsoft Cloud Security Benchmark) | AM-2, DP-1, DP-2, DP-3, DP-6, DP-7, IM-1, IM-2, IR-1, LT-1, LT-2, LT-3, LT-4, LT-5, NS-3 | [MCSB v1](https://learn.microsoft.com/security/benchmark/azure/overview) |
| **RGPD** (EU GDPR) | ART-25, ART-30, ART-32, ART-33, ART-5 | [GDPR Text](https://gdpr-info.eu/) |
| **NIS2** (EU Directive 2022/2555) | ART-21-2a, ART-21-2b, ART-21-2d, ART-21-2f, ART-21-2h, ART-21-2i | [NIS2 Directive](https://eur-lex.europa.eu/eli/dir/2022/2555) |
| **WAF** (Well-Architected Framework) | — | [Azure WAF](https://learn.microsoft.com/azure/well-architected/) |

## Per-Component Compliance

| Component | Controls |
|-----------|----------|
| resource-group | CAF: RG-1, RG-2, GOV-1 |
| log-analytics | CAF: OPS-1, OPS-2, GOV-3 | MCSB: LT-1, LT-2, LT-3, LT-4, LT-5, IR-1 | RGPD: ART-30, ART-32, ART-33 | NIS2: ART-21-2b, ART-21-2f |
| managed-identity | CAF: ID-1, ID-2 | MCSB: IM-1, IM-2 | RGPD: ART-25, ART-32 | NIS2: ART-21-2i |
| key-vault | CAF: SEC-3, SEC-4 | MCSB: DP-1, DP-2, DP-3, DP-6, DP-7 | RGPD: ART-32 | NIS2: ART-21-2h |
| cognitive-account | CAF: APP-2, DATA-1 | MCSB: DP-1, DP-3, NS-3, IM-1 | RGPD: ART-32, ART-25, ART-5 | NIS2: ART-21-2a, ART-21-2d |
| search-searchservice | CAF: DATA-1, APP-2 | MCSB: DP-1, DP-3, NS-3, IM-1 | RGPD: ART-32, ART-25 | NIS2: ART-21-2a, ART-21-2d |
| storage-account | CAF: DATA-1 | MCSB: DP-1, DP-3, NS-3, AM-2 | RGPD: ART-32, ART-5 | NIS2: ART-21-2h |

---

## Limitations & What This Stack Does NOT Cover

- Azure AD Conditional Access policies are NOT configured (organizational policy)
- Azure DDoS Protection Plan is NOT included (cost: ~2 700€/month)
- Microsoft Defender for Cloud is NOT enabled (requires tenant-level configuration)
- Custom DNS, hybrid connectivity (ExpressRoute/VPN) require additional configuration

These items are **organizational or tenant-level responsibilities** and must be addressed
separately as part of your compliance program.

---

## Enterprise Requirements Checklist

Use this section to map your organization's security requirements to this stack.

| Requirement | AethronOps Default | Your Enterprise Policy | Status |
|-------------|-------------------|----------------------|--------|
| Data encryption at rest | AES-256 (Azure managed keys) | ☐ CMEK required? _____ | ☐ |
| Data encryption in transit | TLS 1.2 enforced | ☐ mTLS required? _____ | ☐ |
| Network isolation | Private endpoints (basic) | ☐ VNet mandatory? _____ | ☐ |
| Identity & Access | Managed Identity + RBAC | ☐ Conditional Access? _____ | ☐ |
| Backup & Recovery | 7d retention | ☐ Your RPO/RTO: _____ | ☐ |
| Data residency | westeurope | ☐ Allowed regions: _____ | ☐ |
| Logging & Monitoring | Log Analytics + App Insights | ☐ SIEM integration? _____ | ☐ |
| Vulnerability scanning | Checkov (IaC scan) | ☐ Additional scanners? _____ | ☐ |
| Tag policy | environment, managed_by, pattern | ☐ Required tags: _____ | ☐ |
| Cost management | FinOps tiers (basic/standard/premium) | ☐ Budget alert? _____ | ☐ |

---

## Recommended Azure Policies (Post-Deployment)

Apply these Azure Policies to enforce compliance at the subscription/management group level:

```hcl
# Suggested Azure Policy assignments for this stack
# Add to a custom_policies.tf file

# 1. Require HTTPS on storage accounts
# Policy: "Secure transfer to storage accounts should be enabled"
# ID: 404c3081-a854-4457-ae30-26a93ef643f9

# 2. Require TLS 1.2 minimum
# Policy: "Latest TLS version should be used in your API App/Web App/Function App"
# ID: f0e6e85b-9b9f-4a4b-b67b-f730d42f1b0b

# 3. Require tags on resources
# Policy: "Require a tag on resources"
# ID: 871b6d14-10aa-478d-b590-94f262ecfa99

# 4. Allowed locations (data residency)
# Policy: "Allowed locations"
# ID: e56962a6-4747-49cd-b67b-bf8b01975c4c

# 5. Deny public IP addresses (for tier standard/premium)
# Policy: "Network interfaces should not have public IPs"
# ID: 83a86a26-fd1f-447c-b59d-e51f44264114

# 6. Require Key Vault for secrets
# Policy: "Key vaults should have soft delete enabled"
# ID: 1e66c121-a66a-4b1f-9b83-0fd5c6d73f60

# 7. Enable diagnostic settings
# Policy: "Deploy diagnostic settings for Key Vault to Log Analytics workspace"
# ID: 951af2fa-529b-416e-ab6e-066fd85ac459
```

> For a full Azure Policy initiative aligned with your compliance goals,
> see [Microsoft Cloud Security Benchmark policy initiative](https://learn.microsoft.com/azure/governance/policy/samples/azure-security-benchmark).

---

## How to Add Custom Requirements

1. **Azure Policy**: Create a `custom_policies.tf` file with your policy assignments
2. **Checkov**: Add custom checks in `.checkov.yaml` or a `custom_checks/` directory
3. **Tags**: Set `custom_tags` variable with your mandatory tags
4. **Network**: Set `require_private_endpoints = true` for zero-trust mode
5. **CMEK**: Add `disk-encryption-set` brick for customer-managed keys
6. **SIEM**: Export Log Analytics to Azure Sentinel or your SIEM via diagnostic settings

---
*Generated by AethronOps v2 — Security controls are embedded in the Terraform code and verifiable via `terraform plan`.*
*This document is an audit preparation aid, not a compliance certification.*
