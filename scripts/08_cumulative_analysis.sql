/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	year,
	total_sales,
	SUM(total_sales) OVER (ORDER BY year) as running_total_sales,
	AVG(avg_price) OVER (ORDER BY year) as moving_avg_price
FROM(
SELECT 
	DATETRUNC(YEAR, order_date) as year,
	SUM(sales_amount) as total_sales,
	AVG(price) as avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date) )t
