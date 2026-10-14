# Customer Transaction Analytics (CTA) Suite
### SQL-Based Customer Intelligence & Transaction Analysis

![SQL Server](https://img.shields.io/badge/MS%20SQL%20Server-CC2927?style=flat)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Report-F2C811?style=flat)
![Status](https://img.shields.io/badge/Status-Analytics%20Portfolio%20Project-2E8B57?style=flat)

---

## Overview

**Customer Transaction Analytics (CTA)** is a relational-data analytics project exploring customer purchases, order activity, payment outcomes and business segmentation through **SQL, Python and Power BI**.

The repository includes a five-table transactional dataset, extensive T-SQL query files, a Python exploratory-analysis notebook and a Power BI project. The focus is on transforming linked records into repeatable business questions and interpretable metrics.

> **Data / impact boundary:** The published CSV extracts are sample project data; the repository does not document evidence of an actual company's recovered revenue. Payment-recovery values are **hypothetical scenarios**, not money collected or proven recoverable.

---

## Business Problem

Transactional data is fragmented across customers, purchases, items, products and payments. Without joins and consistent metric definitions, teams can misinterpret revenue, customer retention, order value and payment failures.

**Questions explored:**

- Which customer segments contribute most to observed transactions?
- How do order volume and sales vary over time and by category?
- Where do failed or pending payments appear in the data?
- Can SQL window functions and CTEs support RFM-style and cohort analysis?
- How can Python charts and BI views communicate the results?

**Approach:** Reconstruct relationships across five tables, develop SQL queries of increasing complexity, inspect distributions in Python, and build supporting reporting artifacts.

---

## Project Structure

```text
Customer-Transaction-Analytics-/
├── customers_export.csv              # Customer sample (150 rows)
├── products_export.csv               # Product sample (80 rows)
├── orders_export.csv                 # Orders (605 rows)
├── order_items_export.csv            # Order line-items (1,442 rows)
├── payments_export.csv               # Payments (605 rows)
├── CTA_Analytics_Suite.sql           # Numbered analytical query suite
├── CTA_queries.sql                   # Additional SQL exercises and analyses
├── Business_Intelligence_Queries.sql # BI-oriented SQL queries
├── Technical_Evaluation_Suite.sql    # Technical query exercises
├── RetailSales Practice Queries.sql  # Additional SQL practice
├── foundationalqueries.sql           # Foundational SQL statements
├── analysis.ipynb                    # Python-based exploratory analysis
├── export_data.py                    # Data export utility
├── test_connection.py                # Database connectivity utility
├── Model_VIew_CTA.pbix               # Power BI report/model artifact
├── dashboard images/                # Report screenshots
└── README.md
```

**The structure above reflects the files actually published on GitHub.** Older documentation referred to nested `SQL_Queries/` or `Notebooks/` folders that are not present in the current root layout.

---

## System Architecture

```text
           Five relational CSV extracts
                    │
                    ▼
         Customers / Orders / Items
              Products / Payments
                    │
                    ▼
          SQL Server / T-SQL layer
             Joins · CTEs ·
         Windows · Aggregations
                    │
       ┌────────────┴────────────┐
       ▼                         ▼
 SQL analysis outputs       Python / Pandas
 Segments, trends,           Exploratory Data
 payment status                    │
       │                         ▼
       └────────────┬────── Matplotlib / Seaborn
                    │
                    ▼
             Power BI artifact
           (`Model_VIew_CTA.pbix`)
```

**Verification boundary:** The five CSV exports were independently loaded. The SQL code and Power BI file are present, but the complete database-to-report pipeline was **not** rerun in the Colab audit.

---

## Dataset

Five committed CSV extracts were independently readable on October 13, 2026:

| Table / CSV | Rows | Columns | Purpose |
|---|---:|---:|---|
| [`customers_export.csv`](customers_export.csv) | 150 | 5 | Customer details and grouping |
| [`products_export.csv`](products_export.csv) | 80 | 4 | Product catalogue |
| [`orders_export.csv`](orders_export.csv) | 605 | 5 | Order headers and amounts |
| [`order_items_export.csv`](order_items_export.csv) | 1,442 | 4 | Products and quantities per order |
| [`payments_export.csv`](payments_export.csv) | 605 | 4 | Payment methods and statuses |

**Observed payment statuses in the published extract:**

| Payment status | Records |
|---|---:|
| Success | 444 |
| Failed | 94 |
| Pending | 67 |
| **Total** | **605** |

The original business provenance and data-generation method are not fully established by the current README; treat these as **project sample exports** rather than verified live retail records.

---

## Tech Stack

| Layer | Technologies | Repository evidence |
|---|---|---|
| Relational analysis | SQL Server / T-SQL | [`CTA_Analytics_Suite.sql`](CTA_Analytics_Suite.sql) |
| Query techniques | JOINs, CTEs, ranking/window functions, grouped aggregations | [`CTA_queries.sql`](CTA_queries.sql) |
| Data inspection | Python, Pandas, NumPy | [`analysis.ipynb`](analysis.ipynb) |
| Charts | Matplotlib, Seaborn | Python notebook |
| Reporting | Power BI | [`Model_VIew_CTA.pbix`](Model_VIew_CTA.pbix) |
| Exports / connectivity | Python utility scripts | [`export_data.py`](export_data.py), [`test_connection.py`](test_connection.py) |
| Version control | Git / GitHub | This repository |

---

## SQL Analytics & Evaluation

The repository's numbered SQL analysis suite covers foundational, intermediate and more complex techniques.

| Analytical area | Example objective | Main technique |
|---|---|---|
| Sales trends | Compare sales across periods | Grouping, date aggregation |
| Customer behaviour | Identify purchase frequency and value | Joins, aggregates |
| RFM-style segmentation | Evaluate recency, frequency, monetary value | CTEs, window functions |
| Product performance | Compare category/item contribution | Multi-table joins |
| Cohort / retention | Compare first purchase and return periods | Date logic, CTEs |
| Payment failures | Estimate amount associated with failed payments | CASE, joins, grouped sums |
| Customer scorecards | Combine several analytics measures | Multiple CTEs |

**Independent verification:** Published CSVs were loaded and row counts/payment-status counts confirmed. Exact SQL results, correctness of business formulas and Power BI visuals were **not independently executed or validated** in that check.

### Payment Recovery: Important Interpretation

The SQL payment-audit section calculates a **scenario estimate** using a formula equivalent to:

```sql
estimated_recovery_value = failed_revenue * 0.50
```

That 50% is an **assumption**, not a measured recovery rate. An earlier README stated approximately **₹39K in recoverable revenue**; this monetary value has **not** been independently recomputed and should not be stated as recovered revenue or a guaranteed financial opportunity.

A defensible description is: **"Implemented SQL queries that explore failed payments and calculate assumption-based recovery scenarios."**

---

## Key Findings

- **Relational depth:** Five linked entities enable analysis beyond simple one-table summaries.
- **Payment-status profile:** The published sample includes 94 failed and 67 pending payment records, out of 605 payment rows.
- **Reusable SQL skills:** The query suite demonstrates joins, window functions and CTE-driven customer analysis.
- **Interpretation matters:** Recovery assumptions must be declared; failed order/payment amounts do not automatically equal recoverable revenue.
- **Reproducibility opportunity:** Running selected SQL statements against a documented, rebuilt schema would strengthen the project evidence.

Screenshots are available in [`dashboard images/`](dashboard%20images/).

---

## Phase Completion

| Phase | Deliverable | Status |
|---|---|---|
| 1 | Five relational sample datasets | ✅ Independently loaded |
| 2 | SQL analytics query suite | ✅ Files present; outputs not independently rerun |
| 3 | Python EDA | ✅ Notebook present; full execution not retested |
| 4 | Power BI report / model | 📁 `.pbix` and screenshots present |
| 5 | Verified revenue-recovery impact | ❌ Not claimed |
| 6 | End-to-end reproducibility check | 🔄 Further validation recommended |

---

## Getting Started

### Prerequisites

- Microsoft SQL Server and SSMS (or equivalent compatible environment) for T-SQL scripts
- Python 3.x, Jupyter, Pandas, NumPy, Matplotlib and Seaborn
- Power BI Desktop for the `.pbix` report

### Setup

```bash
git clone https://github.com/BitsbyBhargav/Customer-Transaction-Analytics-.git
cd Customer-Transaction-Analytics-
python -m pip install pandas numpy matplotlib seaborn jupyter
```

### Recommended Exploration Order

1. Inspect the five `*_export.csv` files and identify customer–order–item–product–payment relationships.
2. Review [`CTA_Analytics_Suite.sql`](CTA_Analytics_Suite.sql) from foundational through advanced queries.
3. Create/import a compatible SQL Server schema matching the five CSV column types and keys; verify counts before using the queries. **An all-in-one verified database setup script is not claimed.**
4. Execute the selected SQL statements and document their actual output and assumptions.
5. Run [`analysis.ipynb`](analysis.ipynb) after adjusting paths for your local directory.
6. Open [`Model_VIew_CTA.pbix`](Model_VIew_CTA.pbix) and verify its expected data connections.

---

## Limitations & Future Scope

- Document dataset provenance, business rules and any synthetic-data generation.
- Validate join cardinality to avoid multiplying revenue across line items or repeated payment attempts.
- Reproduce selected payment and customer-segmentation figures with captured SQL output.
- Distinguish attempted, settled and failed revenue consistently.
- Add a short reproducibility script/schema and refresh instructions for the Power BI report.

---

## Project Context

**Type:** Independent SQL and analytics portfolio project.  
**Focus:** SQL reasoning, relational modelling, customer segmentation and BI-oriented analysis.  
**Impact:** Analytical scenarios only; no verified real business revenue recovery.

---

## Author

**Bhargav Sonawane**  
Computer Science — Big Data & Cloud Engineering · MIT ADT University

[GitHub](https://github.com/BitsbyBhargav) · [LinkedIn](https://www.linkedin.com/in/bhargav-sonawane-b50605327/) · [Portfolio](https://bitsbybhargav.github.io/)

---

## Usage & Attribution

The repository currently does not include a `LICENSE` file. Confirm reuse permissions and record the sample data's original provenance before redistributing it for other purposes.
