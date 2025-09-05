--Finding the first and the last order dates
--How many years of sales are available?
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

--The oldest and the youngest birthdates
SELECT
	MAX(birthdate) AS oldest_date,
	MIN(birthdate) AS youngest_date
FROM gold.dim_customers;

--Age of the oldest and the youngest customers
SELECT 
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS youngest_age,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS oldest_age
FROM gold.dim_customers;

--Find the youngest and the oldest customers
SELECT 
	first_name,
	last_name
FROM gold.dim_customers
WHERE birthdate = (SELECT MIN(birthdate) FROM gold.dim_customers);

SELECT 
	first_name,
	last_name
FROM gold.dim_customers
WHERE birthdate = (SELECT MAX(birthdate) FROM gold.dim_customers);