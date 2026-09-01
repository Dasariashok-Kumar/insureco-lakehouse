# InsureCo Lakehouse — Project

An end-to-end mini insurance data platform built on **Azure Databricks** 
, demonstrating core Lakehouse patterns: Delta Lake, 
Structured Streaming, Auto Loader, Medallion Architecture, Delta Live 
Tables, Data Quality, Job Orchestration, Unity Catalog governance, and 
Databricks SQL dashboards.

---

## Project Overview

**Domain:** Property & Casualty / Health Insurance  
**Dataset:** Simulated InsureCo data — Customers, Agents, Policies, 
Premium Payments, Claims, Underwriting Risk (~83,000 rows, generated 
programmatically with intentional data quality issues for testing)

**Architecture:** Medallion (Bronze → Silver → Gold) on Delta Lake, 
governed by Unity Catalog, orchestrated via Databricks Jobs.

---

## Architecture

See [`diagrams/architecture.md`](diagrams/architecture.md) for the full 
architecture diagram and data flow.

**Summary:**
Raw Files (Volumes) → Auto Loader → Bronze (Delta)
→ Data Quality Rules → Silver (Clean) + Quarantine
→ Aggregation → Gold (Business Metrics)
→ Databricks SQL Dashboards + Jobs Orchestration

---

## Repository Structure
insureco-lakehouse/
├── 00_setup/ # Data generation & Unity Catalog setup
├── lakehouse_basics/ # Delta Lake fundamentals, managed vs external tables
├── compute_clusters/ # Cluster configuration notes
├── streaming_autoloader/ # Structured Streaming, Auto Loader, Medallion
├── quality_jobs_sql/ # Data quality, DLT, Jobs, Databricks SQL
├── governance_git/ # Unity Catalog grants, governance model
├── diagrams/ # Architecture diagrams
└── docs/ # Data dictionary



---

## Key Features Implemented

| Feature | Description | Location |
|---|---|---|
| **Delta Lake** | Managed + external tables, ACID transactions, time travel | `day1_lakehouse_basics/` |
| **Structured Streaming** | Auto Loader incremental ingestion with checkpointing | `day3_streaming_autoloader/` |
| **Medallion Architecture** | Bronze → Silver → Gold layered processing | `day3_`, `day4_` |
| **Data Quality** | Quarantine pattern with 5 explicit validation rules | `day4_quality_jobs_sql/Day4_Step1_DataQuality.py` |
| **Delta Live Tables** | Declarative pipeline with EXPECT constraints | `day4_quality_jobs_sql/Day4_DLT_Pipeline_Source.py` |
| **Job Orchestration** | 3-task dependency chain with parameters | `day4_quality_jobs_sql/Day4_Task*.py` |
| **Databricks SQL** | Dashboards for Loss Ratio, Fraud Rate, Agent Performance | Screenshots in `docs/` |
| **Unity Catalog Governance** | 3-level namespace, GRANT/REVOKE, lineage | `day5_governance_git/` |

---

##  Sample Business Metrics Produced

- **Loss Ratio by Policy Type** — identifies unprofitable policy lines
- **Fraud Rate by Region** — highlights regions needing fraud investigation focus
- **Top 10 Agents by Premium Generated** — sales performance ranking
- **Claims Summary by Status** — operational claims pipeline visibility

---

## Tech Stack

- **Compute:** Databricks Free Edition (Serverless)
- **Storage:** Unity Catalog Volumes (Delta Lake format)
- **Languages:** PySpark, Spark SQL
- **Orchestration:** Databricks Jobs & Workflows
- **Governance:** Unity Catalog (catalog.schema.table, GRANT/REVOKE)
- **Visualization:** Databricks SQL Dashboards
- **Version Control:** Git / GitHub (Databricks Repos)

---

## How to Run This Project

1. Clone this repo into a Databricks Workspace via **Repos** → **Add Repo**
2. Run `00_setup/` to generate sample data
3. Run `lakehouse_basics/*` to create initial Delta tables
4. Run `streaming_autoloader/*` to build the streaming Bronze layer
5. Run `quality_jobs_sql/Day4_Step1_DataQuality.py` for Silver/Gold
6. Import the Job JSON pattern from `quality_jobs_sql/` into **Workflows**
7. Run SQL queries from `quality_jobs_sql/SQL_Queries.sql` in SQL Editor

---

## What I Learned

- Building Medallion Architecture pipelines from raw files to business-ready Gold tables
- Implementing data quality patterns using quarantine tables (not silent deletion)
- Writing declarative ETL using Delta Live Tables with automatic quality metrics
- Orchestrating multi-task dependency chains with Databricks Jobs
- Governing data access using Unity Catalog's 3-level namespace and GRANT/REVOKE
- Version-controlling Databricks notebooks with Git integration

---

## Author

**Ashok Dasari**  
[LinkedIn]https://www.linkedin.com/in/dasariashokkumar/ | [GitHub]https://github.com/Dasariashok-Kumar

---
