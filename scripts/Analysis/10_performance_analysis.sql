/*========================================================================================================================
	Performance Analysis
==========================================================================================================================
	Script Purpose:
		1.) Measure performance of products, customers, or regions over time.
		2.) For benchmarking and identifying high_performing entities
		3.) Track yearly trends and growth

	SQL functioins used:
		1.) LAG():Access data from previous season
		2.) AVG(): Computes average values within partitions
		3.) CASE: Define conditional logic for trend analysis

==========================================================================================================================
*/

--Analyze the annual performance of products by comparing each product's sales to both its average sales prformance and
--the previous year sales
WITH yearly_product_sales AS
(SELECT
	YEAR(order_date) AS order_year,
	product_name,
	SUM(sales_amount) AS current_sales
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products AS pr
ON sa.product_key = pr.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), product_name)

SELECT 
	order_year,
	product_name,
	current_sales,
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sales,
	current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_py,
	CASE 
		WHEN current_sales > LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) 
			THEN 'Increase'
		WHEN current_sales < LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) 
			THEN 'Decrease'
		ELSE 'No Change'
	END AS py_change,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	CASE 
		WHEN current_sales > AVG(current_sales) OVER(PARTITION BY product_name) 
			THEN 'Above Average'
		WHEN current_sales < AVG(current_sales) OVER(PARTITION BY product_name) 
			THEN 'Below Average'
		ELSE 'Average'
	END AS avg_change
FROM yearly_product_sales
ORDER BY product_name, order_year;
