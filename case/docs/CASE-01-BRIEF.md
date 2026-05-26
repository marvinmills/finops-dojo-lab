# Case 01: ClarionFlow AI
## 100-Day Post-Acquisition FinOps and Architecture Assessment

## Context

ClarionFlow AI is a mid-market B2B SaaS company that provides AI-assisted workflow automation for operations teams.

Over the past 12 months, ClarionFlow AI has expanded its AI-enabled features and acquired a separate AI platform that now runs alongside its legacy core product and shared services (represented in the data as acquired-ai-platform, legacy-core-prod, and shared-services). As a result, customer usage, product complexity, and AWS spend have all increased.

ClarionFlow AI is owned by a private equity–backed operator, which has brought you in during the first 100 days after the AI platform acquisition to run a focused FinOps and architecture assessment. Leadership wants a clear understanding of AWS cost drivers across the acquired AI platform and existing workloads, and the actions required to improve financial discipline without undermining growth or product delivery.


## Your Role

You are acting as an interim FinOps practitioner engaged by the private equity–backed owner of ClarionFlow AI and embedded with the ClarionFlow team during the post-acquisition period.

Your job is to help ownership and ClarionFlow leadership answer a practical question:

How should ClarionFlow AI improve cloud cost visibility, operating discipline, and AWS efficiency across the acquired AI platform, legacy core product, and shared services over the next 100 days, while keeping spend aligned with its highest‑value growth bets and preserving business momentum?



## Business Situation

ClarionFlow AI has recently acquired an AI platform that is now integrated into its environment. The PE-backed owner wants a disciplined post-acquisition view of cloud and AI spend, and a practical plan for improving financial discipline without damaging growth or product delivery.


Leadership has identified several concerns:
- AWS spend has risen quickly over the past year.
- New AI-related features and the acquired AI platform appear to be changing cost patterns.
- Finance lacks confidence in current cost visibility and allocation.
- Engineering has focused primarily on speed, uptime, and delivery.
- Shared services and environments may not be consistently governed.
- Leadership wants actionable recommendations, not just reporting.
- The PE owner expects a clear 30/60/90-day view of actions, risks, and upside that can be used directly in board and investment discussions.


The company needs:
- clearer spend visibility,
- a view of major cost drivers,
- a practical optimization plan,
- and an operating cadence for ongoing FinOps work.




## Stakeholders

You should assume the case involves the following stakeholder perspectives:

- **CEO** — wants clarity, action, and confidence in the operating plan.
- **CFO** — wants improved visibility, better forecasting, and margin discipline.
- **CTO** — wants to maintain reliability and engineering effectiveness.
- **VP Product** — wants AI-enabled features to continue supporting growth.
- **Engineering Managers** — want recommendations that are practical and technically credible.
- **Sales / Customer-facing leadership** — want cost actions that do not harm important customer relationships.




## Your Objectives

Your deliverables should help the company:

- Understand the current AWS cost structure in business terms (products, customers, accounts such as acquired-ai-platform, legacy-core-prod, and shared-services).

- Identify likely areas of inefficiency, waste, or poor allocation that are not advancing key business objectives or the PE owner’s value-creation plan.

- Separate technical issues from process and governance issues so leadership knows where to invest attention.

- Recommend a 30/60/90-day action plan that a PE/search-fund owner and ClarionFlow’s operator-CEOs can realistically execute with existing teams.

- Define a realistic ongoing FinOps operating cadence.

- Develop an initial view of unit economics, forecastability, and financial risks relevant to the CFO, PE/search-fund owner, and post-acquisition decision-making (for example, which workloads and AI features are most worth further investment).




## Materials You Will Use

You will work from:

- a synthetic AWS cost and usage dataset,
- a provided Terraform v1 configuration for the baseline AWS environment,
- a simplified AWS architecture scope,
- your own analysis in Python / notebooks / SQL,
- CloudWatch dashboards or equivalent analytical views,
- and supporting documentation in the repo.

The dataset is designed to support realistic FinOps analysis and should be treated as a stand-in for cloud billing and usage records.

The Terraform v1 configuration is provided so you can stand up the initial environment, load or connect the dataset, and then treat that environment as the inherited baseline for the rest of the case.




## Required Deliverables

Produce the following:

- A baseline AWS cost analysis
- A view of spending by major dimension (such as service, environment, team, or product)
- A list of prioritized optimization opportunities
- A 30/60/90-day action plan
- A detailed analyst report (`CASE-01-REPORT.md`)
- A short executive brief or presentation
- A proposed weekly and monthly FinOps operating cadence
- A CloudWatch dashboard or equivalent visibility layer for key metrics, trends, and findings




## Working Assumptions

As you work the case, make your assumptions explicit.

Where data is incomplete or ambiguous:
- state the limitation,
- explain how it affects your interpretation,
- and avoid false precision.

Your job is not only to identify cost issues, but to demonstrate sound practitioner judgment under realistic business conditions.




## Guiding Questions

As you work the case, consider:

- What appears to be driving AWS spend?
- Which spending patterns are easy to explain, and which require deeper investigation?
- Which findings are primarily technical? Which are organizational?
- What actions would be safe and high-confidence in the first 30 days?
- What actions require more validation, stakeholder buy-in, or architectural review?
- What operating rhythm would help the company improve continuously rather than react occasionally?




## Learning Objectives (Platform + FinOps)

By completing this case, you should be able to:

- Explain the end-to-end AWS architecture (network, app, data, observability) in plain language.
- Walk through each Terraform file and describe what resources it manages and why.
- Describe how cost, performance, and reliability tradeoffs influenced the design.
- Modify the Terraform configuration safely in response to a change request (e.g., new region, new SLO, budget cut).