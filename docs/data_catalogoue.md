# Data Dictionary for the gold layer

## Overview
The gold layer represents business-level data, structured to support analytical and repetitive use cases.
It consists of **dimension tables** and **fact tables** for specific business metrics

---

### 1. **gold.dim_customers**
- **Purpose:** Stores customers' details enriched with demographic and geographic data
- **columns:**
  
| Column Name            | Data Type          | Description                                                                           |
| -----------------------|--------------------|---------------------------------------------------------------------------------------|
| customer_key           | INT                | Surrogate key uniquely identifies each customer record in the dimension table         |
| customer_id            | INT                | Unique numerical identifier assigned to each customer                                 |
| customer_number        | NVARCHAR(50)       | Alphanumeric identifier representing the customer, used for tracking  and referencing |
| first_name             | NVARCHAR(50)       | The customer's first name as recorded in the system                                   |
| last_name              | NVARCHAR(50)       | The customer's last name or family name                                               |
| country                | NVARCHAR(50)       | The country of residence for the customer (e.g. 'Australia')                          |
| marital status         | NVARCHAR(50)       | The marital status of the customer (e.g., 'Married', 'Single')                        |
| gender                 | NVARCHAR(50)       | The gender of the customer (e.g., 'Male', 'Female')                                   |
| birthdate              | DATE               | The date of birth of the customer formatted as YYYY-MM-DD (e.g. 1971-10-06)           |
| create_date            | DATE               |The date and time when the customer record was created in the system                   |

---

### 2. **gold.dim_products**
- **purpose:** Provide information about the products and their attributes.
- **Columns**

  | Column Name| Data Type | Description |
  |------------|-----------|-------------|
  | product_key| INT |Surrogate key uniquely identifying each product record in the product dimension table |
  | product_id| INT| A unique identifier assigned to the product for internal tracking and referencing|
  | product_number| NVARCHAR(50)| A structured alphanumeric code representing the product, often used for categorisation and inventory|
  | product_name |NVARCHAR(50)|Descriptive name of the product, including key details such as type, colour and size.|
  | category_id|NVARCHAR(50)| A unique identifier for the products category |
  | category|NVARCHAR(50)||
  | subcategory|NVARCHAR(50)||
  | maintenance|NVARCHAR(50)||
  | product_line|NVARCHAR(50)||
  | create_date| DATE||
