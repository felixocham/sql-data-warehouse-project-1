/*
========================================================================
Report Products
========================================================================
Purpose:
	-This report consolidates key product metrics and behaviours.
	Highlights:
			1. Gathers essential fields such as product name,subcategory, and cost.
			2. Segements products by revenue to indentify High-performance, Mid_Range, or Low-Performers.
			3. Aggregates product - level metrics:
				- total orders
				- total quantity sold
				- total customers (Unique)
				- lifespan (in months)
			4. Calculate valuable KPIs:
				- recency (months since the last sale)
				- average order revenue (AOR)
				- average monthly revenue 
========================================================================
*/
--======================================================================
-- Create report: gold.report_products
--======================================================================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
	DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS

WITH base_query AS(
/*------------------------------------------------------------------------
	1.) Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------*/
SELECT 
	pr.product_key,
	pr.product_name,
	pr.subcategory,
	pr.category,
	pr.product_line,
	pr.cost,
	pr.start_date,
	sa.order_date,
	sa.sales_amount,
	sa.quantity,
	sa.order_number,
	sa.customer_key
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products AS pr
ON sa.product_key = pr.product_key
WHERE order_date IS NOT NULL)

,product_aggregation AS(
/*------------------------------------------------------------------------
	2.) product_aggregation: summarizes key metrics at the products level.
-------------------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	subcategory,
	category,
	product_line,
	cost,
	SUM(quantity)AS total_quantity,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT order_number)AS total_orders,
	COUNT(DISTINCT customer_key)AS total_customers,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date))AS lifespan,
	MAX(order_date)AS last_order,
	ROUND(AVG(sales_amount / NULLIF(quantity,0)), 1) AS average_selling_price
FROM base_query
GROUP BY product_key,
		 product_name,
		 subcategory,
		 category,
		 product_line,
		 cost
)
/*------------------------------------------------------------------------
	3.) Final_Query: Combines all products results into one output.
-------------------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	subcategory,
	category,
	product_line,
	cost,
	total_sales,
	CASE
		WHEN total_sales > 50000 THEN 'High Performer'
		WHEN total_sales >= 10000 THEN 'Mid Range'
		ELSE 'Low Performer'
	END AS product_segment,
	total_orders,
	DATEDIFF(MONTH, last_order, GETDATE()) AS recency_in_months,
	total_customers,
	last_order,
	-- Compute average order revenue
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales/total_orders
	END AS average_order_revenue,
	average_selling_price,

	--Compute average  monthly revenue
	CASE
		WHEN lifespan = 0  THEN total_sales
		ELSE total_sales/lifespan
	END AS average_monthy_revenue
FROM product_aggregation


