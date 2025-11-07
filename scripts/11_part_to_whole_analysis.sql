/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

-- Categories contributing the most to overall sales
WITH categories_sales as(
SELECT
	p.category,
	SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category)
SELECT 
	category,
	total_sales,
	CAST(ROUND(CAST(total_sales as float)*100 / SUM(total_sales) OVER (),2) as NVARCHAR)+' %' as percentage
FROM categories_sales
ORDER BY total_sales DESC
