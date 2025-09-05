/*========================================================================================================================
	Cumulative Analysis
==========================================================================================================================
	Script Purpose:
		1.) To calculate running totals or moving average for key metrics.
		2.) Tracks the performance over time cumulatively.
		3.) Useful for growth analysis or identifiying long_term trends 

	SQL functioins used:
		1.) Window fuctions: SUM() OVER() .
==========================================================================================================================
*/
 
 --Calculate total sales per month
 --and the running totals of the sales overtime
 SELECT
	order_date,
	total_revenue,
	SUM(total_revenue) OVER(ORDER BY order_date) AS running_totals
FROM ( 
 SELECT
	DATETRUNC(MONTH, order_date) AS order_date,
	SUM(sales_amount) AS total_revenue
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date))t

--Year to date sales and Moving average price
SELECT
	order_date,
	total_revenue,
	SUM(total_revenue) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) AS running_total,
	AVG(average_price) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) AS moving_average
FROM
	(SELECT 
		DATETRUNC(MONTH, order_date) AS order_date,
		SUM(sales_amount) AS total_revenue,
		AVG(price) AS average_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date))t