/*========================================================================================================================
	Part to Whole Analysis
==========================================================================================================================
	Script Purpose:
		1.) To compare performance or metrics across dimensions or time periods.
		2.) To evaluate differences between categories.
		3.) Useful for A/B testing or regional comparison

	SQL functioins used:
		1.) To evaluate differences between categories.
		2.) Window fuctions: SUM() OVER() for total calculations.
==========================================================================================================================
*/

--Which categories contribute the most to the overall sales?
SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND(total_sales/SUM(total_sales) OVER() * 100, 2), '%' ) AS pct_by_cat
FROM
(SELECT 
	category,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales AS sa
LEFT JOIN gold.dim_products AS pr
ON sa.product_key = pr.product_key
GROUP BY category) t
ORDER BY total_sales DESC;
