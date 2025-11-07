/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/
-- Total Customers by Countries
SELECT country, COUNT(DISTINCT customer_key) as total_customer,
CAST((SUM(DISTINCT customer_key) * 100.0) / (SELECT SUM(DISTINCT customer_key) FROM gold.dim_customers) as DECIMAL(10,2)) as percentage_of_total
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customer DESC

-- Total Customers by Gender
SELECT gender, COUNT(DISTINCT customer_key) as total_customer,
CAST((COUNT(customer_key) * 100.0) / (SELECT COUNT(customer_key) FROM gold.dim_customers) as DECIMAL(10,2)) as percentage_of_total
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customer DESC

-- Total Product by Category
SELECT category, count(product_key) as total_products,
CAST((COUNT(product_key) * 100.0) / (SELECT COUNT(product_key) FROM gold.dim_products) as DECIMAL(10,2)) as percentage_of_total
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

-- Average Cost in each Category
SELECT category, AVG(cost) as avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC

-- Total Revenue Generated for each Category
SELECT p.category, SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

-- Total Revenue by Customers
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) as total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC

-- Distribution of sold items across countries
SELECT
	c.country,
	SUM(s.quantity) as total_sold_items,
	CAST(SUM(s.quantity)* 100.0 / (SELECT SUM(quantity) FROM gold.fact_sales) as decimal(10,2)) as percentage
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC
