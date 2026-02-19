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


-- to see data from the table
SELECT * FROM retail_sales 
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning
-- identify null values
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
	WHERE 
		transaction_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		gender IS NULL
		OR 
		category IS NULL
		OR 
		quantity IS NULL
		OR
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR
		total_sale IS NULL;

-- delete the rows that have null columns
DELETE FROM retail_sales 
	WHERE 
		transaction_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		gender IS NULL
		OR 
		category IS NULL
		OR 
		quantity IS NULL
		OR
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR
		total_sale IS NULL;

-- Data Exploration
-- How many sales do we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- How many unique categories do we have?
SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales;

-- What are the categories?
SELECT DISTINCT category FROM retail_sales;


-- Data Analysis and Business Key Problems 

-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE 
	sale_date = '2022-11-05';

-- Q2. Write an SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of November-2022
SELECT * FROM retail_sales
	WHERE 
			category = 'Clothing'
		AND 
			TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
		AND 
			quantity >=4;

-- Q3. Write an SQL query to calculate the total sales (total_sale) for each category
SELECT category, SUM(total_sale) as net_sale, COUNT(*) as total_orders FROM retail_sales
	GROUP BY 1;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT category, ROUND(AVG(age), 2) as average_age FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1;

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
	WHERE total_sale > 1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(*) as total_transaction FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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

-- Q8. Write a SQL query to find the top 5 customers based on highest total_sales
SELECT customer_id, SUM(total_sale) as total_sales  FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT(DISTINCT customer_id) as cnt_unique_cs FROM retail_sales
GROUP BY category;

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <= 12, Afternoon between 12 and 17, Evening > 17)

WITH hourly_sale
AS 
(
SELECT *,
CASE
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
	ELSE 'Evening'
END as shift
FROM retail_sales
) 
SELECT shift, COUNT(*) as total_orders FROM hourly_sale
GROUP BY shift;

-- Q11. What is the overall profit margin? 
-- profit_margin = (total_sales - COGS) / revenue
SELECT 
	SUM(total_sale) as total_revenue, 
	SUM(cogs) as total_cogs,
	SUM(total_sale - cogs) as total_profit,
	ROUND(
        (SUM(total_sale - cogs) / NULLIF(SUM(total_sale), 0))::numeric * 100, 
        2
    ) AS profit_margin_percentage
	
FROM retail_sales;

-- Q12. Which category has the highest profit margin?
SELECT 
	category,
	SUM(total_sale) as total_revenue, 
	SUM(cogs) as total_cogs,
	SUM(total_sale - cogs) as total_profit,
	ROUND(
        (SUM(total_sale - cogs) / NULLIF(SUM(total_sale), 0))::numeric * 100, 
        2
    ) AS profit_margin_percentage
FROM retail_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC
LIMIT 1;


-- Q13. Which hour of the day has the highest revenue generated?
SELECT
	EXTRACT(HOUR FROM sale_time) as sale_hour,
	SUM(total_sale) as total_revenue FROM retail_sales
	GROUP BY sale_hour
	ORDER BY total_revenue DESC
	LIMIT 1;
	
-- Q14. Which day of the week generates the highest revenue?
SELECT  
	TO_CHAR(sale_date, 'Day') as day_of_the_week,
	SUM(total_sale) as total_revenue
	FROM retail_sales
	GROUP BY day_of_the_week
	ORDER BY total_revenue DESC
	LIMIT 1;
