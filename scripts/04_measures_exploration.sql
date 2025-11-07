/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
-- Find Total Sales
SELECT CAST(SUM(sales_amount)/1000000 as NVARCHAR) + 'M $' as Total_Sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) as sold_items FROM gold.fact_sales

-- Find average selling price
SELECT AVG(price) as avg_price FROM gold.fact_sales

-- Find total number of orders
SELECT count(DISTINCT order_number) as total_orders FROM gold.fact_sales

-- Find total number of products
SELECT count(DISTINCT product_key) as total_products FROM gold.dim_products

-- Find total number of customers
SELECT count(customer_key) as total_cutomers FROM gold.dim_customers

-- Find total number of customers that has placed an order
SELECT count(DISTINCT customer_key) as active_customers from gold.fact_sales

-- Generate a Report Showing all Key Metrics of the Business
SELECT 'Total Sales' as MEASURE_NAME, SUM(sales_amount) as MEASURE_VALUE FROM gold.fact_sales
UNION ALL
SELECT 'Sold Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', count(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', count(DISTINCT product_key) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', count(customer_key) FROM gold.dim_customers
UNION ALL
SELECT 'Active Customers', count(DISTINCT customer_key)from gold.fact_sales
