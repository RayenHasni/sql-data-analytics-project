## SQL Data Analytics Project

A comprehensive collection of T-SQL scripts for exploring, analyzing, segmenting and reporting on sales data stored in a SQL Server data warehouse.

This repository is a toolkit for data analysts and BI professionals to quickly run exploratory queries, build KPI reports, and demonstrate end-to-end analytical thinking. It is also structured to showcase practical skills for job-seeking data analysts: data modelling, analytical SQL, window functions, aggregation patterns, and reporting via views.

## 🗺️ Project Roadmap

- datasets/ — sample CSVs used to seed or inspect local data (medallion layers represented as bronze/silver/gold CSVs).
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

![Project Roadmap](https://github.com/RayenHasni/sql-data-warehouse-project/blob/main/docs/Data%20Architecture.png)

## Project purpose

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

## Inputs / Outputs (contract)

- Inputs: materialized gold tables (at minimum `gold.fact_sales`, `gold.dim_customers`, `gold.dim_products`) with typical columns (order_date, sales_amount, quantity, product_key, customer_key, product attributes, customer attributes).
- Outputs:
  - Ad-hoc query results returned by the `scripts/*.sql` queries
  - Views created by scripts: `gold.report_customers`, `gold.report_products`
  - A set of example CSVs and a backup file for local experimentation in `datasets/`

 ## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

Success criteria
- Queries run on SQL Server (T-SQL) without syntax errors
- Views return expected aggregated KPIs and columns documented in the scripts
