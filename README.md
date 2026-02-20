# Retail Sales Analysis
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
5. 



