/*========================================================================================================================
	Rank Analysis
==========================================================================================================================
	Script Purpose:
		1.) Rank items(products, customers, e.t.c) based on performance or other metrics.
		2.) Identify top or bottom performers 
	SQL functioins used:
		1.) Windows ranking functions: ROW_NUMBER(), RANK(), TOP, 
		2.) clauses: GROUP BY, ORDER BY

==========================================================================================================================
*/

--Which 5 products generated the highest revenue
SELECT TOP (5)
	product_name,
	SUM(sales_amount) AS Total_revenue
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products pr
ON sa.product_key = pr.product_key
GROUP BY product_name
ORDER BY 2 DESC;

--Using the window functions to solve same problem
SELECT * FROM
(SELECT 
	product_name,
	SUM(sales_amount) AS Total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(sales_amount) DESC) AS rank_products
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products pr
ON sa.product_key = pr.product_key
GROUP BY product_name)t
WHERE rank_products <= 5;


--Which 5 subcategories generated the highest revenue
SELECT TOP (5)
	subcategory,
	SUM(sales_amount) AS Total_revenue
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products pr
ON sa.product_key = pr.product_key
GROUP BY subcategory
ORDER BY 2 DESC;

--What are worst performing product in terms of sales
SELECT TOP (5)
	product_name,
	SUM(sales_amount) AS Total_revenue
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products pr
ON sa.product_key = pr.product_key
GROUP BY product_name
ORDER BY 2 ASC;

--What are worst performing subcategory in terms of sales
SELECT TOP (5)
	subcategory,
	SUM(sales_amount) AS Total_revenue
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products pr
ON sa.product_key = pr.product_key
GROUP BY subcategory
ORDER BY 2 ASC;

--Top 10 customers who have generated the highest revenue.
SELECT
	TOP(10)
	cu.first_name,
	cu.last_name,
	SUM(sales_amount) AS Total_revenue
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_customers AS cu
ON sa.customer_key = cu.customer_key
GROUP BY cu.first_name,cu.last_name
ORDER BY 3 DESC;

--OR
SELECT * FROM
(SELECT
	cu.first_name,
	cu.last_name,
	SUM(sales_amount) AS Total_revenue,
	RANK() OVER(ORDER BY SUM(sales_amount) DESC) AS customer_rank
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_customers AS cu
ON sa.customer_key = cu.customer_key
GROUP BY cu.first_name,cu.last_name)t
WHERE customer_rank <= 10;

--3 customers with the fewest orders placed
SELECT
	cu.customer_number,
	cu.first_name,
	cu.last_name,
	COUNT(DISTINCT order_number)AS Nr_orders,
	RANK() OVER(ORDER BY COUNT(DISTINCT order_number)) AS customer_rank
FROM gold.fact_sales sa 
LEFT JOIN gold.dim_customers cu
ON sa.customer_key = cu.customer_key
GROUP BY cu.customer_number,cu.first_name,cu.last_name;
