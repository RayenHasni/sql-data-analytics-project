## SQL Data Analytics Project

A comprehensive collection of T-SQL scripts for exploring, analyzing, segmenting and reporting on sales data stored in a SQL Server data warehouse (gold layer used).

This repository is a toolkit for data analysts and BI professionals to quickly run exploratory queries, build KPI reports, and demonstrate end-to-end analytical thinking. It is also structured to showcase practical skills for job-seeking data analysts: data modelling, analytical SQL, window functions, aggregation patterns, and reporting via views.

## What this project contains

- datasets/ — sample CSVs and a backup (`DataWarehouseAnalytics.bak`) used to seed or inspect local data (medallion layers represented as bronze/silver/gold CSVs).
- scripts/ — T-SQL scripts grouped by analytical purpose. Key scripts:
  - `01_database_exploration.sql` — inspect tables / schema
  - `02_dimensions_exploration.sql` — inspect dimension table values
  - `03_date_range_exploration.sql` — temporal boundary checks
  - `04_measures_exploration.sql` — totals, averages, counts (key metrics)
  - `05_magnitude_analysis.sql` — distribution of measures across dimensions
  - `06_ranking_analysis.sql` — product/customer ranking queries
  - `07_change_over_time_analysis.sql` — trends / time series grouping
  - `08_cumulative_analysis.sql` — running totals / moving averages
  - `09_performance_analysis.sql` — YoY / trend comparisons using window functions
  - `10_data_segmentation.sql` — product and customer segmentation examples
  - `11_part_to_whole_analysis.sql` — part-to-whole (percentage of total)
  - `12_report_customers.sql` — view: `gold.report_customers` (customer-level KPIs)
  - `13_report_products.sql` — view: `gold.report_products` (product-level KPIs)

## Project purpose (short)

This repo demonstrates how to take cleaned and integrated data (gold layer) and:
- Explore and validate the data model and temporal coverage
- Build aggregate metrics and KPIs (sales, quantity, AOV, recency, lifespan)
- Segment customers and products for targeted analysis
- Produce reusable reporting artifacts (views) that feed dashboards or stakeholders

## Architecture & data flow

This project expects a medallion-style warehouse (bronze -> silver -> gold). The scripts operate primarily on the gold layer tables:
- `gold.dim_customers` — dimension table for customers
- `gold.dim_products` — dimension table for products
- `gold.fact_sales` — fact table with transactional sales

Note: you indicated the data warehouse (medallion architecture) is built in another repo and that data from the gold layer there was used here — this repository focuses on analytics and reporting using that gold layer.

## Inputs / Outputs (contract)

- Inputs: materialized gold tables (at minimum `gold.fact_sales`, `gold.dim_customers`, `gold.dim_products`) with typical columns (order_date, sales_amount, quantity, product_key, customer_key, product attributes, customer attributes).
- Outputs:
  - Ad-hoc query results returned by the `scripts/*.sql` queries
  - Views created by scripts: `gold.report_customers`, `gold.report_products`
  - A set of example CSVs and a backup file for local experimentation in `datasets/`

Success criteria
- Queries run on SQL Server (T-SQL) without syntax errors
- Views return expected aggregated KPIs and columns documented in the scripts

## How to run the scripts (locally with SQL Server)

1. Restore the backup (optional) using SQL Server Management Studio (SSMS) or `sqlcmd`.

2. From PowerShell you can run a script using `sqlcmd` (example):

```powershell
sqlcmd -S <server> -d <database> -i .\scripts\01_database_exploration.sql -U <user> -P <password>
```

3. Or open the `.sql` file in SSMS and run interactively. The scripts use T-SQL functions such as `DATETRUNC`, `DATEDIFF`, `GETDATE()`, window functions and assume SQL Server (T-SQL) syntax.

## Quick verification checks (recommended)
- Run `01_database_exploration.sql` to confirm expected `gold.*` tables exist.
- Run `03_date_range_exploration.sql` to learn the temporal coverage of `fact_sales`.
- Run `12_report_customers.sql` and `13_report_products.sql` to create and validate reporting views.

## Small issues I noticed (suggested immediate fixes)
- `scripts/12_report_customers.sql` contains a missing comma or small syntax mistakes near `total_products` / `lifespan` in the final SELECT — please fix the comma separation before creating the view.
- Always test the `CREATE VIEW` scripts in a transaction or in SSMS to see T-SQL-specific `GO` placement and permissions.

## Why this is good for an interview / hiring showcase
- Demonstrates practical data modelling (dimensions + facts) and medallion architecture
- Shows ability to write production-ready T-SQL: aggregations, window functions, null-safe math, segmentation
- Produces reusable artifacts (views) which is a common BI deliverable
- The scripts map directly to dashboard KPIs (AOV, recency, avg monthly spend, product segment) — great to demo

## Next steps / recommended improvements
- Add a README in `datasets/` describing the CSVs and how they map to the gold schema
- Add unit/integration checks (tiny SQL tests) to ensure view columns exist and return non-null results
- Add a small sample dashboard (Power BI / Looker / Tableau) to showcase the outputs visually
