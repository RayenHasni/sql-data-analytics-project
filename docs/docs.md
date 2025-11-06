This document expands on the README with technical details useful for interviews and hand-offs.

### Project overview

This is an analytics-first SQL repository that assumes a SQL Server-based data warehouse following a medallion pattern (bronze → silver → gold). The repository focuses on queries and reporting logic executed against the gold layer.

### Core tables / expected schema (summary)

- gold.fact_sales (example columns):
  - order_number, order_date, product_key, customer_key, sales_amount, price, quantity
- gold.dim_customers (example columns):
  - customer_key, customer_number, first_name, last_name, birthdate, gender, country, other attributes
- gold.dim_products (example columns):
  - product_key, product_name, category, subcategory, cost, other attributes

Note: column names are referenced in scripts; if your gold schema uses different names adapt the scripts or add a mapping layer.

### Script themes & patterns

- Exploration: `01_database_exploration.sql`, `02_dimensions_exploration.sql`, `03_date_range_exploration.sql` — quick checks to understand data quality and scope.
- Aggregation & measures: `04_measures_exploration.sql`, `05_magnitude_analysis.sql` — totals, averages and distribution analysis.
- Ranking & segmentation: `06_ranking_analysis.sql`, `10_data_segmentation.sql` — RANK/ROW_NUMBER usage and CASE-based segmentation.
- Time analysis: `07_change_over_time_analysis.sql`, `08_cumulative_analysis.sql`, `09_performance_analysis.sql` — time bucketing, running totals, YoY with `LAG()` and windowed averages.
- Reporting: `12_report_customers.sql`, `13_report_products.sql` — views intended to be consumed by dashboards.

### KPI definitions (as used in views)

- Total Sales: SUM(sales_amount)
- Total Orders: COUNT(DISTINCT order_number)
- Average Order Value (AOV): total_sales / total_orders (guarded against division by zero)
- Recency (customer): months since last order
- Lifespan: months between first and last order

### Common SQL techniques showcased

- Defensive aggregation (NULLIF / CASE to avoid divide-by-zero)
- Window functions: `SUM() OVER`, `AVG() OVER`, `RANK()`, `LAG()`
- Date truncation and formatting (`DATETRUNC`, `FORMAT`, `DATEDIFF`)
- Reusable view creation and modular CTEs for clarity and testing
