/*
===========================================================================================
Quality Checks
===========================================================================================
Script Purpose:
  Performs quality checks to validate the integrity, consistency and accuracy of the gold 
  layer. These checks ensure:
      - Uniqueness of the surrogate keys in the dimension tables.
      - Referential integrity between the fact and dimension tables
      - Validation of the relationship in the model for analytical purposes.
Usage Notes:
    - Run the checks after loading data into the gold layer.
    - Investigate and resolve any discrepancies found during the checks
===========================================================================================
*/

--=========================================================================================
--Checking 'gold.dim_customers'
--=========================================================================================
--check for the uniqueness of the customer key in the gold.dim_customers
-- Expectation: No Results
SELECT
  customer_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

--========================================================================================= 
--Checking 'gold.dim_product'
--========================================================================================= 
--check for the uniqueness of the product_key in the gold.dim_products
-- Expectation: No Results
SELECT
  product_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY customer_key
HAVING COUNT(*) > 1;

--========================================================================================= 
--Checking 'gold.fact_sales'
--=========================================================================================
--Checking the data model connectivity between fact and dimension tables
--Expectation: No Results
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
