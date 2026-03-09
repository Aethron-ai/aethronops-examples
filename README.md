# AethronOps — Free Azure Infrastructure Examples

Production-ready Terraform stacks built with **Azure Verified Modules (AVM)** — Microsoft's official, maintained Terraform modules.

Each example is a complete, deployable infrastructure stack with:
- CAF naming conventions
- Managed Identity (zero secrets)
- Key Vault for secret management
- Log Analytics monitoring
- Compliance documentation (CAF, MCSB, RGPD, NIS2)

## Examples

| Stack | Description | Azure Services | Est. Cost |
|-------|-------------|----------------|-----------|
| [storage-baseline-mini](./storage-baseline-mini/) | Secure blob storage with versioning and soft-delete | Storage Account, Key Vault, Log Analytics | ~5€/month |
| [appservice-web-mini](./appservice-web-mini/) | Web application on App Service | App Service (B1), Key Vault, Log Analytics | ~15€/month |
| [rag-baseline-mini](./rag-baseline-mini/) | RAG AI pipeline with OpenAI + Search | Azure OpenAI, AI Search, Storage, Key Vault | ~30€/month |

> Cost estimates are for **dev/basic** tier in West Europe. Production tiers are higher.

## Architecture Diagrams

### storage-baseline-mini

```mermaid
graph LR
    subgraph Resource Group
        MI[🔑 Managed Identity]
        KV[🔐 Key Vault]
        ST[📦 Storage Account<br/>Blob · LRS]
        LA[📊 Log Analytics]
    end

    MI -->|access policy| KV
    MI -->|auth| ST
    ST -.->|diagnostics| LA
    KV -.->|diagnostics| LA

    style MI fill:#4FC3F7,stroke:#0288D1,color:#000
    style KV fill:#CE93D8,stroke:#7B1FA2,color:#000
    style ST fill:#81C784,stroke:#388E3C,color:#000
    style LA fill:#FFB74D,stroke:#F57C00,color:#000
```

### appservice-web-mini

```mermaid
graph LR
    U[👤 Users] -->|HTTPS| APP

    subgraph Resource Group
        MI[🔑 Managed Identity]
        KV[🔐 Key Vault]
        APP[🌐 App Service<br/>Plan B1 · Linux]
        LA[📊 Log Analytics]
    end

    MI -->|access policy| KV
    MI -->|auth| APP
    APP -.->|diagnostics| LA
    KV -.->|diagnostics| LA
    APP -->|secrets| KV

    style U fill:#E0E0E0,stroke:#757575,color:#000
    style MI fill:#4FC3F7,stroke:#0288D1,color:#000
    style KV fill:#CE93D8,stroke:#7B1FA2,color:#000
    style APP fill:#64B5F6,stroke:#1565C0,color:#000
    style LA fill:#FFB74D,stroke:#F57C00,color:#000
```

### rag-baseline-mini — RAG AI Pipeline

```mermaid
graph TB
    U[👤 Users] -->|query| APP[Your Application]

    subgraph Resource Group
        direction TB
        MI[🔑 Managed Identity]
        KV[🔐 Key Vault]
        OAI[🧠 Azure OpenAI<br/>GPT · Embeddings]
        SRCH[🔍 AI Search<br/>Cognitive Search]
        ST[📦 Storage Account<br/>Documents · Blob]
        LA[📊 Log Analytics]
    end

    APP -->|1. embed query| OAI
    APP -->|2. vector search| SRCH
    APP -->|3. generate answer| OAI
    ST -->|indexer| SRCH
    SRCH -->|enrichment| OAI
    MI -->|auth| OAI
    MI -->|auth| SRCH
    MI -->|auth| ST
    MI -->|access policy| KV
    OAI -.->|diagnostics| LA
    SRCH -.->|diagnostics| LA

    style U fill:#E0E0E0,stroke:#757575,color:#000
    style APP fill:#E0E0E0,stroke:#757575,color:#000
    style MI fill:#4FC3F7,stroke:#0288D1,color:#000
    style KV fill:#CE93D8,stroke:#7B1FA2,color:#000
    style OAI fill:#EF5350,stroke:#C62828,color:#fff
    style SRCH fill:#AB47BC,stroke:#6A1B9A,color:#fff
    style ST fill:#81C784,stroke:#388E3C,color:#000
    style LA fill:#FFB74D,stroke:#F57C00,color:#000
```

### AethronOps — How It Works

```mermaid
graph LR
    CAT[📋 54 Stack Types<br/>× 3 sizes × 3 envs] -->|generate| ENG[⚙️ AethronOps Engine]
    ENG -->|produces| TF[📁 Terraform Code<br/>AVM Modules]
    TF -->|terraform apply| AZ[☁️ Azure<br/>Infrastructure]

    ENG -->|also generates| DOC[📄 README<br/>COMPLIANCE<br/>DISCLAIMER]

    style CAT fill:#FFF176,stroke:#F9A825,color:#000
    style ENG fill:#64B5F6,stroke:#1565C0,color:#000
    style TF fill:#81C784,stroke:#388E3C,color:#000
    style AZ fill:#4FC3F7,stroke:#0288D1,color:#000
    style DOC fill:#FFCC80,stroke:#EF6C00,color:#000
```

## Quick Start

```bash
# 1. Pick a stack
cd storage-baseline-mini

# 2. Configure your environment
cp environments/dev.tfvars my.tfvars
# Edit my.tfvars — set project_name and subscription_id

# 3. Deploy
terraform init
terraform plan -var-file=my.tfvars
terraform apply -var-file=my.tfvars
```

## What is AethronOps?

AethronOps generates production-ready Azure infrastructure as code. These free examples showcase a fraction of the **54 stack types** available, each in 3 sizes (mini, medium, full) and 3 environments (dev, uat, prod).

Full catalog includes:
- **Landing Zones** — Hub-Spoke networking, governance
- **Web & API** — App Service, Functions, Container Apps, API Management
- **AI & ML** — RAG pipelines, ML workspaces, Cognitive Services
- **Data** — SQL, Cosmos DB, Data Factory, Databricks
- **Containers** — AKS, Container Apps, Container Registry
- **Infrastructure** — VMs, VMSS, Load Balancers, Static Sites

### Why AVM?

Azure Verified Modules are:
- Maintained by **Microsoft** (not community)
- Tested and validated against Azure best practices
- Updated with every Azure API change
- The **recommended** way to write Terraform for Azure

## Stack Structure

Every AethronOps stack follows the same structure:

```
stack-name/
├── main.tf              # Providers, locals, random resources
├── variables.tf         # Input variables with validation
├── outputs.tf           # Stack outputs
├── resource_group.tf    # Resource group module
├── identity.tf          # Managed Identity
├── keyvault.tf          # Key Vault for secrets
├── monitoring.tf        # Log Analytics workspace
├── *.tf                 # Service-specific resources
├── environments/
│   └── dev.tfvars       # Environment configuration
├── backend.tf.example   # Remote state template
├── README.md            # Quick start guide
├── COMPLIANCE.md        # Security & compliance matrix
├── DISCLAIMER.md        # Legal disclaimer
├── SOURCES.md           # AVM module versions & links
└── manifest.yaml        # Stack metadata
```

## Security & Compliance

All stacks implement:
- **MCSB** — Microsoft Cloud Security Benchmark controls
- **CAF** — Cloud Adoption Framework naming & structure
- **RGPD/GDPR** — Data protection by design (Art. 25, 32)
- **NIS2** — Network and information security measures

> These are technical controls, not certifications. See DISCLAIMER.md in each stack.

## License

These examples are provided under the [MIT License](./LICENSE). See DISCLAIMER.md in each stack for important legal information.

---

Built with [AethronOps](https://github.com/Aethron-ai/aethronops) — Azure infrastructure, done right.
