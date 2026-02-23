# Retail Sales Performance & Profitability Analysis
## Overview
This project analyzes retail transaction data using SQL to uncover insights related to:
* Revenue performance
* Customer behaviour
* Product category trends
* Profitability
* Time-based sales pattern

## Objective
The objective of this project was to simulate real-world business questions and solve them using advanced SQL techniques.

## Dataset
The dataset, ```SQL - Retail Sales Analysis_utf```, contains transactional retail sales data with the following key fields:
* ```transaction_id```
* ```sale_date```
* ```sale_time```
* ```customer_id```
* ```gender```
*  ```age```
*  ```category```
*  ```quantity```
*  ```price_per_unit```
*  ```cogs``` (Cost of Goods Sold)
*  ```total_sale```

Each row represents a single sales transaction

## Database Setup
* Database: Create the database for the project - ```retail_sales_analysis_p1```
* Table: Create a table named ```retail_sales``` to store the sales data. The columns include, ```transaction_id```, ```sale_date```, ```sale_time```, ```customer_id```, ```gender```, ```age```, ```category```, ```quantity```, ```price_per_unit```, ```cogs``` and ```total_sale```.

```sql
-- SQL Retail Sales Analysis - P1
CREATE DATABASE retail_sales_analysis_p1;

-- Create Table
CREATE TABLE retail_sales
(
		transaction_id int PRIMARY KEY,
		sale_date date, 
		sale_time time,	
		customer_id	int, 
		gender varchar(15), 
		age	int,
		category varchar(15),
		quantity int,
		price_per_unit float,
		cogs float,
		total_sale float
);
```

### 2. Exploratory Data Analysis and Data Cleaning 
* Sales Count: Total number of sales made
* Customer Count: Number of unique customers
* Category Count and Name: Number of unique categories
* Null Value Check: Identify any null values in the dataset and delete the records with missing data

### 3. Data Analysis and Findings
#### Basic Sales Analysis
1. Retrieve all transactions from a specific date.
2. Filter category-specific transactions within a given month.
3. Calculate total sales per category.
4. Identify high-value transactions (total_sale > 1000)

#### Customer Insights
5. Average age of customers purchasing Beauty products.
6. Number of transactions by gender and category.
7. Top 5 customers by total revenue.
8. Unique customers per category.

#### Time-Based Analysis
9. Best-selling month in each year.
10. Revenue by hour of day.
11. Revenue by day of week.
12. Sales distribution by shift (Morning/Afternoon/Evening).

#### Profitability Analysis
13. Overall profit margin.
14. Category with the highest profit margin.

### 4. SQL Concepts Demonstrated
This project demonstrates:
* ```WHERE``` filtering
* ```GROUP BY``` & aggregations (SUM, AVG, COUNT)
* ```COUNT(DISTINCT)```
* Date functions (```EXTRACT```, ```TO_CHAR```)
* Window functions (```RANK() OVER```)
* CTEs (```WITH```)
* KPI calculations (profit margin)
* NULL handling with ```NULLIF```
* Business metric derivation

### 5. Sample Advanced Query (Best-Selling Month per Year)
```sql
SELECT year, month, avg_total_sale FROM 
(
	SELECT EXTRACT(YEAR FROM sale_date) as year, 
	EXTRACT(MONTH FROM sale_date) as month, 
	AVG(total_sale) as avg_total_sale, 
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1, 2
	) as t1
	WHERE rank = 1;

```
This query uses window functions to determine the highest-performing month for each year. 

### 6. Key Insights 
#### Revenue Insights
* The highest revenue is generated at 7 PM, suggesting peak shopping occurs in the evening.
* Sunday generates the most revenue, indicating strong weekend demand.
* In 2022, July had the highest average monthly sales at $541.34. In 2023, February led with $535.53. Even though the highest-performing months differ between 2022 and 2023, the peak averages are nearly identical, with only a 1.08% difference, suggesting a relatively stable year-over-year sales performance.

#### Profitability Insights
* The overall profit margin is 79.19%, indicating healthy cost control.
* The Beauty Category has the highest profit margin at 79.71%, despite not necessarily having the highest revenue.
* Clothing and Electronics categories have lower margins, suggesting pricing or cost inefficiencies.

#### Customer Insights
* Beauty attracts younger customers on average.
* Gender based purchasing is evident across categories. Female customers account for a larger share of transactions in Beauty and Clothing, while male customers dominate Electronics purchases.
* Clothing attracts the largest number of unique customers and generates the highest total transactions, highlighting it as a category with the broadest appeal and strongest engagement.

#### Category Performance Insights
* Electronics contributes 34.42% of total revenue, making it the highest-revenue category. Electronics purchases have a higher order value, making it a high-value category for revenue growth.

### 7. Business Value
This analysis can help stakeholders:
* Identify peak revenue periods
* Optimize staffing my shift
* Improve pricing strategy using margin analysis
* Focus marketing efforts on high-value customers
* Allocate inventory based on the time of the year (ie. seasonal trends)

### 8. Future Improvements
* Build an interactive dashboard (Tableau/Power BI
* Forecast sales using time series modelling (Python)
* Build automated reporting pipeline
