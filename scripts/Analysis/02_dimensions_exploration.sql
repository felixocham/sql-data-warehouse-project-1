/*========================================================================================================================
	Dimension Analysis
==========================================================================================================================
	Script Purpose:
		1.) Explore the structure of dimension table


	SQL functioins used:
		1.) DISTINCT.
		2.) ORDER BY.
==========================================================================================================================
*/
--Explore the countries our customers come from
SELECT DISTINCT country
FROM gold.dim_customers;

--Explore the product categories(Major divisions)
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1, 2, 3;
