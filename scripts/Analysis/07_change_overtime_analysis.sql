/*========================================================================================================================
	Change Overtime Analysis
==========================================================================================================================
	Script Purpose:
		1.) Track trends, growth, and changes in key metric overtime.
		2.) For time series analysis and identifying seasonality.
		3.) To measure growth or decline over specific periods

	SQL functioins used:
		1.) Date functions: YEAR(), DATEPART(), DATETRUNC(), FORMAT()
		2.) Aggregate functions: SUM(), COUNT(), AVG().
==========================================================================================================================
*/

--Changes over years
SELECT
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS total_revenue,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE YEAR(order_date) IS NOT NULL
GROUP BY  YEAR(order_date)
ORDER BY YEAR(order_date);

--Seasonality trends(months)
SELECT
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_revenue,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE MONTH(order_date) IS NOT NULL
GROUP BY  YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

--OR
SELECT
	DATETRUNC(MONTH, order_date) AS order_date,
	SUM(sales_amount) AS total_revenue,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date);

--OR
SELECT
	FORMAT(order_date, 'yyyy-MMM') AS order_date,
	SUM(sales_amount) AS total_revenue,
	COUNT(DISTINCT customer_key) total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM');
