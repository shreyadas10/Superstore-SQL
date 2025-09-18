-- SQL SUPERSTORE PROJECT

-- Creating Database  'project1'
CREATE DATABASE project1;

-- Using Database 'projct1'
USE project1;

-- Retrieve al the records of superstore data
SELECT * FROM superstore;

-- Number of rows
SELECT COUNT(*) FROM superstore;

-- Retrieve al the records of superstore data
SHOW COLUMNS FROM superstore;

-- QUESTIONS

-- 1. Get the unique ship mode 
SELECT DISTINCT `Ship Mode`  FROM superstore;

-- 2. Count how many orders were placed
SELECT COUNT(DISTINCT `Order ID`) AS Number_of_Orders FROM superstore;

-- 3. Show  total sales per category
SELECT Category,ROUND(SUM(Sales),2)AS tottal_sales FROM superstore
GROUP BY Category;

-- 4. List all customers from California

SELECT DISTINCT `Customer Name` , State FROM superstore 
WHERE State = 'California';

-- 5. find the total number of unique customers
SELECT COUNT(DISTINCT`Customer ID`) AS unique_customers FROM superstore;

-- 6. What is the total profit for the 'Chairs' sub-category 
SELECT `Sub-Category`, ROUND(SUM(Profit),3) AS profit_of_chair FROM superstore
WHERE `Sub-Category`='Chairs';
 
-- 7. Show top 5 products by sales
SELECT `Product Name`, SUM(Sales) AS total_sales FROM superstore 
GROUP BY  `Product Name`
ORDER BY total_sales LIMIT 5 ;

-- 8. Find the earliest and latest order date
SELECT  MIN(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS earliest_date ,
        MAX(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS latest_date
 FROM superstore;
 
-- 9. Average discount er region
SELECT Region, AVG(Discount) AS avg_discount FROM superstore
GROUP BY Region;

-- 10. State with the highest total sale
SELECT State, SUM(Sales)  AS total_sales FROM superstore
GROUP BY State
ORDER BY total_sales DESC LIMIT 1;

-- 11. Total quantity of products sold by sub-category
SELECT `Sub-Category`,SUM(Quantity) AS total_quantity 
FROM superstore
GROUP BY `Sub-Category`;

-- 12. List customers with more than two orders 
SELECT `Customer Name`, COUNT(`Order ID`) AS total_orders FROM superstore
GROUP BY `Customer Name`
HAVING COUNT(`Order ID`) > 2
ORDER BY total_orders DESC ;

-- 13. Number of orders shipped using `Second Class`
SELECT COUNT(DISTINCT(`ORDER ID`)) AS second_class_orders FROM superstore
WHERE `Ship Mode` = 'Second Class';

-- 14. Top 3 sub-categories by profit in each category
SELECT *
FROM(
SELECT Category, `Sub-Category`, SUM(Profit) as total_profit,
RANK() OVER (PARTITION BY Category ORDER BY SUM(Profit) Desc) as rk
FROM superstore
GROUP BY Category, `Sub-Category`)
as ranked_subs
where rk <=3;

-- 15. Find orders with negative profit 
SELECT `ORDER ID`, SUM(Profit) AS negative_profit FROM superstore
GROUP BY `ORDER ID`
HAVING SUM(Profit) < 0;

-- 16. Cities where more than 10000 of sales happened
SELECT city,SUM(sales) as city_sales FROM superstore
GROUP BY city
HAVING SUM(sales) > 10000;

-- 17. Find the product with zero profit but non_zero sales
SELECT `Product Name`, sales, Profit FROM superstore
WHERE Profit = 0 AND Sales > 0;

-- 18. Sub-categories where discount was always 0
SELECT `Sub-Category`, MAX(Discount) AS max_discount FROM superstore
GROUP BY `Sub-Category`
HAVING MAX(Discount)=0;

-- 19. Rank customers by profit in each region
SELECT Region,`Customer Name`,SUM(Profit) AS total_profit,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(Profit) DESC) AS row_num
FROM superstore
GROUP BY Region, `Customer Name`
ORDER BY Region, row_num;

-- 20. Which states have the lowest average sales per order
SELECT state, AVG(sales) AS avg_sales FROM superstore
GROUP BY state
ORDER BY avg_sales ASC;



