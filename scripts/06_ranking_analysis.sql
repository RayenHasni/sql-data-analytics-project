/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
-- Top 5 Product Generating revenue
SELECT TOP 5
	p.product_name, 
	SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- 2nd Solution (Using Window Function)
SELECT * FROM(
SELECT
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) as rank_product,
	p.product_name, 
	SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name)t
WHERE rank_product <=5

-- 5 Worst-Performing Products in terms of revenue
SELECT TOP 5
	p.product_name, 
	SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue

-- Top 10 Customers Generating Revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) as total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC

-- Lowest 5 Customers in terms of number of order
SELECT TOP 5
	c.customer_key,
	c.first_name,
	c.last_name,
	Count(DISTINCT s.order_number) as nb_order
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY nb_order
