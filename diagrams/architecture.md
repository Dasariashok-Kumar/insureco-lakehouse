%md InsureCo Lakehouse — Architecture


                RAW DATA SOURCES
    (Simulated: CSV bulk generator, JSON stream files)
                        │
                        ▼
    ┌───────────────────────────────────────┐
    │   Unity Catalog Volume (Landing Zone) │
    │   /Volumes/insurance_dev/raw_files/   │
    └───────────────────┬───────────────────┘
                        │
            Auto Loader (cloudFiles)
                        │
                        ▼
    ┌───────────────────────────────────────┐
    │         BRONZE LAYER (Delta)          │
    │   insurance_dev.bronze.*              │
    │   Raw, unfiltered, source-preserving  │
    └───────────────────┬───────────────────┘
                        │
          Data Quality Rules + Dedup
                        │
            ┌───────────┴───────────┐
            ▼                       ▼
┌───────────────────┐   ┌───────────────────────┐
│  SILVER LAYER     │   │  QUARANTINE TABLE     │
│  claims_clean     │   │  claims_quarantine    │
│(passed all checks)│   |(failed checks,audited)│
└───────────┬───────────┘└──────────────────────┘
            │
    Business Aggregations
            │
            ▼
┌─────────────────────────────┐
│   GOLD LAYER (Delta)        │
│   claims_summary            │
│   loss_ratio_by_policy_type │
└───────────────────┬─────────┘
                    │
        ┌───────────┴───────────┐
        ▼                       ▼
Databricks SQL              Databricks Jobs
Dashboards & Alerts         (Orchestration:
(Loss Ratio, Fraud Rate,     Bronze→Silver→Gold,
 Top Agents)                 scheduled daily)


 
## Governance
All layers governed by **Unity Catalog** (`insurance_dev` catalog) with 
schema-level GRANT/REVOKE permissions:
- `bronze` → Data Engineers only
- `silver` → Data Engineers + Claims Team  
- `gold`   → All business users (read-only)

## Orchestration 
Azure Data Factory → triggers → Databricks Notebook/Job → 
writes to → Azure ADLS Gen2 → governed by → Unity Catalog