/*========================================================================================================================
	Exploratory Analysis
========================================================================================================================
	Script Purpose:
		1.) Explore the structure of the Database including the list of tables and schemas
		2.) Inspect columns and specific metadata for specific tables
	Tables used:
		1.) INFORMATION_SCHEMA.TABLES
		2.) INFORMATION_SCHEMA.COLUMNS

========================================================================================================================
*/

--Explore all tables in the Database
SELECT *
FROM INFORMATION_SCHEMA.TABLES;

--Explore all columns in the Database
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';



