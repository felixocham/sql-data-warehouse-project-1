/*========================================================================================================================
	Data Segmentation
==========================================================================================================================
	Script Purpose:
		1.) Group data into meaningful categories for target insights.
		2.) Customer segmentation, product categorization or regional analysis.

	SQL functioins used:
		1.) CASE: Defines custom segmentation logic
		2.) GROUP BY: Group data into segments
==========================================================================================================================
*/

/*
Segment product into cost ranges and count how many product fall
into each segment.
*/
WITH product_segments AS
(SELECT 
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100 - 500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500 - 1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_products)
SELECT 
	cost_range,
	COUNT(product_key)AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*Group customers into three segments base on their spending behaviour:
	- VIP: Customers with atleast 12 months of history and spending more than 5000.
	- Regular:Customers with atleast 12 months of history but spending 5000 or less.
	- New: Customer with a life span of less than 12 months
	And find the total number of customers by each group
*/
WITH customer_segment AS
(SELECT
	CASE
		WHEN lifespan >= 12 AND total_expenditure > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_expenditure <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS cust_segment,
	customer_key
FROM
(SELECT 
	sa.customer_key,
	SUM(sales_amount) AS total_expenditure,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_customers AS cu
ON sa.customer_key = cu.customer_key
GROUP BY sa.customer_key)t)
SELECT
	cust_segment,
	COUNT(customer_key) AS Nr_customers
FROM customer_segment
GROUP BY cust_segment
ORDER BY COUNT(customer_key) DESC;
