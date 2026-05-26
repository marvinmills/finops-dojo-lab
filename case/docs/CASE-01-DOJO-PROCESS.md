# Case 01 – FinOps Dojo Practice Process

This file explains **how to work Case 01** so you build:

- FinOps skills (Inform → Optimize → Operate),
- platform / Terraform skills,
- and financial acumen (unit economics, CFO/FP&A, and pre/post-acquisition views).

The case brief describes the scenario and business.  
This process describes the **8-step loop** you use to practice.

There is **no time constraint** – optimize for depth and quality of learning.

---

## Overview: 8-Step FinOps Lead Loop

You will run these steps in a loop:

1. Orient – Context & artifacts  
2. Inspect – Infra, Terraform v1, and dataset  
3. Inform – Cost & usage data  
4. Decide – FinOps opportunities & objectives  
5. Design – Architecture & Terraform changes  
6. Implement – Apply changes in Terraform & tooling  
7. Review & Explain – Tech, cost, finance story, and reporting  
8. Iterate – New baseline, new loop

Think of it as an infinity symbol: left side = understand & inform, right side = decide & change.

---

## 1. Orient – Context & artifacts

Goal: Understand the **business and financial context** before touching infra or code.

From `CASE-01-BRIEF.md` and any other artifacts:

- Summarize in your own words:
  - What does this business do?
  - Who are the key stakeholders (product, CFO/finance, platform, etc.)?
  - What are the primary business goals for this case (growth, margin, stability, readiness for acquisition, etc.)?
- Note explicit constraints, such as:
  - Cost targets, SLAs, compliance, timelines.
- If the case mentions acquisition/exit:
  - Note what an **acquirer** would likely care about (cloud as % of revenue, cost predictability, unit economics, integration risk).

Capture this in a short note (notebook or `notes/`).

---

## 2. Inspect – Infra, Terraform v1, and dataset

Goal: Treat the **initial environment** as inherited, like a real FinOps lead would.

### 2.1 Terraform v1 configuration

- Open the **provided Terraform files** for the chosen baseline architecture for Case 01.
- Understand, at a high level:
  - What resources and modules are defined?
  - Which services are likely to drive cost (compute, storage, databases, networking, observability)?
- Use these files to **stand up the v1 environment**:
  - Run `terraform init`, `terraform plan`, and `terraform apply` in the `terraform/` directory.
  - Verify the environment matches expectations from the brief (environments, region, main components).

### 2.2 Synthetic dataset

- Locate the **synthetic cost/usage dataset** provided for this case.
- Understand:
  - Where and how it will live in AWS (e.g., S3 bucket, Glue catalog + Athena, or RDS).
- Use Terraform and/or simple scripts to:
  - Upload or connect the dataset to the environment (e.g., put objects in S3, define a Glue table, set up an Athena workgroup).
- Confirm you can query or read the dataset (e.g., basic Athena query or Python read).

Once this is done, treat the v1 environment and dataset as the **“existing system”** for the rest of the loop.

---

## 3. Inform – Cost & usage data

Goal: Build a **data-driven picture** of spend and usage.

Using the synthetic cost/billing dataset (and any usage metrics):

- Load the data into a tool:
  - Python (Pandas), SQL (Athena/RDS), or a notebook.
- Clean and normalize:
  - Ensure key fields (service, account, region, tags, environment) are usable.
  - Fix or flag missing/inconsistent tags where necessary. 
- Analyze:
  - Top N services by cost.
  - Cost by environment, account, or tag (product/tenant/team).
  - Trends over time (month-by-month or week-by-week).
  - Any anomalies or spikes.
- Build **unit economics and financial views**:
  - Cost per tenant / customer / order / API call, as appropriate.
  - Cloud cost as % of revenue in this scenario (if revenue is modeled).
  - Identify obvious waste or underutilization.

Capture key findings as bullet points; you’ll use them in Step 4.

---

## 4. Decide – FinOps opportunities & objectives

Goal: Turn context + infra + data into a **short list of priorities**.

Based on Steps 1–3:

- Identify your top FinOps opportunities, such as:
  - Rightsizing compute or databases.
  - Storage optimizations (classes, lifecycle rules).
  - Scheduling/off-hours shutdown for non-prod.
  - Improving tagging/allocation for better showback/chargeback.
  - Reducing volatility and improving forecastability.
- Decide what to target **this iteration**, considering:
  - Business goals (growth vs margin vs reliability).
  - Pre/post-acquisition concerns (e.g., making cost structure more attractive and predictable).
  - Risk and implementation effort.

Record each decision in a **Decision Log** entry:

- Options considered (including any AI suggestions).
- Chosen direction.
- Technical reasoning (performance, reliability).
- Financial reasoning (unit economics, COGS, predictability).

This is a thinking step—no code changes yet.

---

## 5. Design – Architecture & Terraform changes

Goal: Translate decisions into **concrete technical and financial changes**.

For each chosen opportunity:

- Decide how the design should change:
  - Architecture adjustments (e.g., switching storage classes, tightening autoscaling, separating environments).
  - Tagging and account structure improvements that support better allocation.
- Map these to Terraform:
  - What modules/resources need to change?
  - What new variables, locals, or outputs do you need?
  - How will tagging standards be enforced via code?
- Consider the **financial impact** in the design:
  - Expected change to:
    - total monthly spend,
    - unit economics (cost per tenant/customer/order/API),
    - volatility and forecast error.

Sketch a before/after view in both architecture and Terraform terms.

---

## 6. Implement – Apply changes in Terraform & tooling

Goal: **Encode your decisions as “FinOps as code”** and make them visible.

- Update Terraform:
  - Implement the design changes (new or updated resources, modules, tags, lifecycle policies, env separations, etc.).
  - Run `terraform fmt`, `terraform validate`, and inspect `terraform plan` carefully.
- Apply changes:
  - Run `terraform apply` once you are confident in the plan.
- Build or enhance **visibility**:
  - Create or update at least one CloudWatch dashboard and/or equivalent view to visualize:
    - key usage metrics,
    - key cost drivers or proxies (if applicable),
    - any indicators tied to your optimizations.
  - Optionally, complement this with notebook/BI charts for cost/unit metrics.

After this step, the environment should reflect your FinOps decisions in both infrastructure and observability.

---

## 7. Review & Explain – Tech, cost, finance story, and reporting

Goal: Evaluate impact and be able to **tell the story** clearly to technical and executive stakeholders.

### 7.1 Technical & cost review

- Re-run your cost/usage analysis:
  - Did the expected cost drivers move in the direction you wanted?
  - Any new anomalies or regressions?
- Review Terraform:
  - Is the structure clear and safe (no surprise destroys, no unnecessary complexity)?
  - Any new security risks (e.g., public exposure, overly broad IAM)?

### 7.2 Financial acumen check

- Evaluate impact on:
  - Unit economics (cost per tenant/customer/order/API).
  - Volatility (did spend become more or less predictable?).
  - Alignment with business and CFO concerns (e.g., margin, predictability, readiness for acquisition).
- Consider forecastability:
  - Would forecasting next month’s cloud cost be easier now?
  - If you have a simple forecast model, compare expected vs “actual” in the dataset.

### 7.3 Explain it (closed-file recall & defense)

Without code in front of you, practice explaining:

- What you changed and why (in Terraform and architecture terms).
- How those changes impacted cost and unit economics.
- What the CFO/finance team would care about in these results.
- How you would summarize findings to a CTO or platform lead.

### 7.4 Produce reports

Create two artifacts:

1. `CASE-01-REPORT.md` (detailed analyst report)
   - Executive summary.
   - Key cost drivers and unit metrics.
   - Description of changes made and their technical/financial impact.
   - Risks, tradeoffs, and recommended next steps.

2. `CASE-01-EXECUTIVE-BRIEF.md` (or slides)
   - 1–2 page narrative or 5–7 slides aimed at executives.
   - Focus on:
     - What’s happening with cloud cost.
     - Why it matters to the business/financials.
     - What actions you recommend and expected impact.

---

## 8. Iterate – New baseline, new loop

Goal: Treat the updated environment and insights as your **new starting point**.

- The current infra + cost behavior becomes “v2 baseline.”
- Decide what to do next loop:
  - Another optimization theme (e.g., commitments, showback/chargeback, anomaly detection).
  - A deeper financial exercise (e.g., richer forecasting, pre/post-acquisition scenario analysis).
  - Applying the same 8-step loop to a new case.

Each full loop through these steps builds your ability to:

- Read and understand context quickly.
- Understand infra and Terraform at a meaningful level.
- Turn cost data into insights and decisions.
- Encode FinOps decisions as code and observability.
- Communicate clearly to both engineering and finance leadership.

Repeat across multiple cases to compound your skills.