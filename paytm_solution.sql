CREATE DATABASE project;
SHOW databases;
USE project;


ALTER TABLE `project`.`paytme purchase data1` 
RENAME TO  `project`.`paytmepurchasedata1` ;

ALTER TABLE `project`.`paytmepurchasedata1` 
DROP COLUMN `MyUnknownColumn_[0]`,
DROP COLUMN `MyUnknownColumn`;

-- 1. Retrieve all columns for all records in the dataset.
SELECT 
    *
FROM
    paytmepurchasedata1;

--  What does the "Category_Grouped" column represent, and how many unique categories are there?
SELECT 
    Category_Grouped,
    COUNT(DISTINCT (Category_Grouped)) AS unique_categories
FROM
    paytmepurchasedata1
GROUP BY 1;

-- List the top 5 shipping cities in terms of the number of orders.
SELECT 
    shipping_city, count(*) as orders_count
FROM
    paytmepurchasedata1
group BY 1
order by 2 desc
LIMIT 5;

-- Show me a table with all the data for products that belong to the "Electronics" category.
SELECT 
    *
FROM
    paytmepurchasedata1
WHERE
    Category = 'Electronics'
        OR Sub_category = 'Electronics'
        OR Segment = 'Electrnoics';

-- Filter the data to show only rows with a "Sale_Flag" of 'Yes'.
SELECT 
    *
FROM
    paytmepurchasedata1
WHERE
    Sale_Flag = 'On Sale';

-- Sort the data by "Item_Price" in descending order. What is the most expensive item?
SELECT 
    *
FROM
    paytmepurchasedata1
ORDER BY Item_Price DESC
LIMIT 1;

-- Apply conditional formatting to highlight all products with a "Special_Price_effective" value below $5000 in red.
SELECT 
    *
FROM
    paytmepurchasedata1
WHERE
    Special_Price_effective < 50
        AND  Color = 'RED';

-- find the total sales value for each category.
SELECT DISTINCT
    (Category), sum(Quantity * (Item_Price)) AS total_sales
FROM
    paytmepurchasedata1
group by 1    ;

-- Calculate the average "Quantity" sold for products in the "Clothing" category, grouped by "Product_Gender."
SELECT 
    Category_Grouped, Product_Gender ,AVG(Quantity) as avg_quantity
FROM
    paytmepurchasedata1
WHERE
    Category_Grouped = 'Apparels'
GROUP BY Product_Gender;

SELECT 
    Category, Product_Gender ,AVG(Quantity) as avg_quantity
FROM
    paytmepurchasedata1
WHERE
    Category = 'Clothing'
GROUP BY Product_Gender;

-- . Find the top 5 products with the highest "Value_CM1" and "Value_CM2" ratios.
SELECT 
    *
FROM
    paytmepurchasedata1
WHERE
    Value_CM1 / (Value_CM2)
LIMIT 5;
-- --------------------------
SELECT 
    *
FROM
    paytmepurchasedata1
ORDER BY Value_CM1 / Value_CM2 DESC
LIMIT 5;


--  Identify the top 3 "Class" categories with the highest total sales.
SELECT  Class, SUM(Quantity * Item_Price) AS total_sales 
FROM paytmepurchasedata1 
GROUP BY Class 
ORDER BY total_sales DESC 
LIMIT 3;


--  Find the total sales for each "Brand" and display the top 3 brands in terms of sales.
SELECT DISTINCT
    (Brand), sum(Quantity * (Item_Price)) AS total_sales
FROM
    paytmepurchasedata1
    group by 1
ORDER BY 2 DESC
LIMIT 3;

--  Calculate the total revenue generated from "Electronics" category products with a "Sale_Flag" of 'Yes'.
SELECT
category, 
    sum((Quantity * (Item_Price - Cost_Price)) + Special_price) AS total_revenue
FROM
    paytmepurchasedata1
WHERE
    (Category = 'Electronics'
        OR Sub_category = 'Electronics'
        OR Segment = 'Electrnoics')
        AND (Sale_Flag = 'On Sale')
        group by 1;

-- Identify the top 5 shipping cities based on the average order value (total sales amount divided by the number of orders) and display their average order values.
-- Alter table paytmepurchasedata1 ADD Column Total_sale int;
-- insert into paytmepurchasedata1 (Total_sale) values ( (Quantity*( Item_Price)));
-- Alter table paytmepurchasedata1 DROP column Total_sale; 
SELECT 
    Shipping_city,
    SUM(Quantity * Item_Price) AS total_sale,
    COUNT(Item_NM) AS avg_order , SUM(Quantity * Item_Price) / COUNT(Item_NM) as avg_ct 
FROM
    paytmepurchasedata1
GROUP BY
    Shipping_city
ORDER BY
    avg_order DESC
LIMIT 5;

SELECT 
    shipping_city,
    SUM(Quantity * Item_Price) / COUNT(*) AS avg_order_value
FROM
    paytmepurchasedata1
GROUP BY 1
ORDER BY 2
LIMIT 5;

-- Determine the total number of orders and the total sales amount for each "Product_Gender" within the "Clothing" category.
SELECT 
    Product_Gender, count(*) as total_order, sum(Quantity * Item_Price) AS total_sale
FROM
    paytmepurchasedata1
WHERE
    Category = 'Clothing'
    group by 1;
    
SELECT 
    Category_Grouped ,Product_Gender, count(*) as total_order, sum(Quantity * Item_Price) AS total_sale
FROM
    paytmepurchasedata1
WHERE
    Category_Grouped = "Apparels"
    group by 2;    

SELECT DISTINCT
    (Name), COUNT(*)
FROM
    paytmepurchasedata1
GROUP BY 1
ORDER BY 2;

-- Calculate the percentage contribution of each "Category" to the overall total sales.
SELECT DISTINCT
    (category),
    (SUM(Quantity * Item_Price) / (SELECT 
            SUM(Quantity * Item_Price)
        FROM
            paytmepurchasedata1)) * 100 AS percentage_contribution
FROM
    paytmepurchasedata1
GROUP BY category
ORDER BY category DESC;


-- Identify the "Category" with the highest average "Item_Price" and its corresponding average price.
SELECT 
    Category,
    (MAX(Item_Price)) AS max_item_p,
    AVG(Item_Price) AS avg_item_p
FROM
    paytmepurchasedata1
GROUP BY 1
order by 3 desc
limit 1;

-- Find the month with the highest total sales revenue. 


-- Calculate the total sale for each "segment" and avg quantity sold pre order for each segment
SELECT 
    Segment,
    sum(Quantity * Item_Price) AS total_sale,
    AVG(Quantity) AS avg_qun
FROM
    paytmepurchasedata1
GROUP BY 1
ORDER BY 2  DESC
LIMIT 5;






