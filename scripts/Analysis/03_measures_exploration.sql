/*========================================================================================================================
	Measures Exploration (Key Metrics)
==========================================================================================================================
	Script Purpose:
		1.) To calculate key business metrics such as total sales, items sold, average price, and order/customer counts.
		2.) Provides a comprehensive overview of business performance through aggregated metrics.
		3.) Useful for assessing sales performance, customer engagement, and product diversity.

	SQL Functions Used:
		1.) Aggregation functions: SUM(), COUNT(), AVG(), ROUND().
		2.) DISTINCT keyword for unique counts.
		3.) UNION ALL for combining multiple metric results in a single report.
==========================================================================================================================*/

--Find the total sales
SELECT 
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

--Find how many items are sold
SELECT 
	SUM(quantity) AS items_sold
FROM gold.fact_sales;

--Find the average selling price
SELECT
	ROUND(AVG(price), 2) AS average_price
FROM gold.fact_sales;

--Find the total number of orders
SELECT
	COUNT(DISTINCT order_number)
FROM gold.fact_sales;

--Total number of products sold
SELECT 
	COUNT(DISTINCT product_key) 
FROM gold.fact_sales;

--Find the total number of customers
SELECT 
	COUNT(customer_id)
FROM gold.dim_customers;

--Find total number of customers that have placed an order
SELECT
	COUNT(DISTINCT customer_key)
FROM gold.fact_sales;

--Generate a report that shows all the metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Avg_Price' AS measure_name, AVG(price) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Items' AS measure_name, COUNT(DISTINCT product_key) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Customers' AS measure_name, COUNT(customer_key) AS measure_value 
FROM gold.fact_sales;
