# Case 01 — ClarionFlow AI: FinOps Cost Analysis

> **A real-world FinOps engagement simulation for a growth-stage AI-SaaS company.**
> Built by [Harness Nexus Labs](https://harnessnexuslabs.com) as a portfolio
> demonstration of cloud financial operations practice.

---

## Overview

ClarionFlow AI is a fictional AI-SaaS company running three core products on
AWS. This case study applies a full FinOps analysis across four months of
billing data (Oct 2025 – Jan 2026), covering cost visibility, unit economics,
governance scoring, anomaly detection, and waste identification.

**The goal:** demonstrate the kind of analysis, findings, and recommendations
a FinOps practitioner delivers to a PE-backed or growth-stage operator.

---

## Key Findings

| Finding | Detail |
|---------|--------|
| 🔴 **28% dark spend** | Nearly 1 in 3 dollars has no attributable owner |
| 🔴 **2x AI cost growth** | `ai-assistant` and `workflow-intelligence` doubled in 90 days with no forecast revision |
| 🟠 **Cross-team governance gap** | Fargate dark spend concentrated at team boundaries — structural, not just a tagging problem |
| 🟡 **Non-prod overrun** | Dev/staging running at 100%+ of prod cost levels across all products |
| 🟢 **Healthy unit economics** | Cost-per-workflow and margin-per-workflow are positive — efficiency opportunity, not crisis |

---

## Analysis Coverage

| # | Analysis | FinOps Phase |
|---|----------|-------------|
| 1 | Initial EDA & schema exploration | Inform |
| 2 | Forecast baseline cost by product | Inform |
| 3 | Forecast baseline cost by SLA tier | Inform |
| 4 | Unit economics — cost per workflow | Inform |
| 5 | Margin per workflow | Optimize |
| 6 | Volume vs. margin scaling simulation | Optimize |
| 7 | Service-level cost drivers | Inform |
| 9 | Cost by AWS region | Inform |
| 10 | Tagging coverage & allocation quality | Operate |
| 11 | Unallocated dark spend by service | Operate |
| 12 | Anomaly detection (z-score) | Operate |
| 13 | Forecast vs. budget variance | Operate |
| 15 | Team-level chargeback / showback | Operate |
| 17 | SLA tier × product cost efficiency | Optimize |
| 18 | Acquisition phase cost segmentation | Inform |
| — | Fargate deep dive: team × product × allocation | Operate |
| — | Governance scorecard (0–100) | Operate |
| — | Waste identification & recovery estimate | Optimize |

---

## Stack

| Layer | Tool |
|-------|------|
| Data warehouse | AWS Athena |
| Data catalog | AWS Glue |
| Storage | Amazon S3 |
| Analysis | Python, pandas, pyathena |
| Visualization | Plotly |
| Notebook | Jupyter |
| Infrastructure | Terraform (see `/terraform`) |

---