create database pizzasalesanalysis;
use pizzasalesanalysis;
-- Total_Revenue --
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sale;
-- Average Order Value --
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sale;
-- Total_pizza_sold --
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sale;
-- Total Orders --
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sale;
-- Average Pizzas Per Order --
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /  
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
AS Avg_Pizzas_per_order 
FROM pizza_sale;
-- Total Pizzas Sold --
SELECT  
HOUR(order_time) AS order_hours, 
SUM(quantity) AS total_pizzas_sold 
FROM pizza_sale 
GROUP BY HOUR(order_time) 
ORDER BY HOUR(order_time);
-- Total_orders --
SELECT  
WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 3) AS WeekNumber, 
YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) AS Year, 
COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sale 
GROUP BY  
WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 3), 
YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) 
ORDER BY Year, WeekNumber;
-- % of Sales by Pizza Category (PCT) --
SELECT  
pizza_category, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue, 
CAST(SUM(total_price) * 100.0 /(SELECT SUM(total_price) FROM 
pizza_sale) AS DECIMAL(10,2) ) AS PCT FROM pizza_sale GROUP BY 
pizza_category;
-- % of Sales by Pizza Size --
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS 
total_revenue,CAST(SUM(total_price) * 100.0 /(SELECT SUM(total_price) FROM 
pizza_sale) AS DECIMAL(10,2)) AS PCT FROM pizza_sale GROUP BY pizza_size 
ORDER BY pizza_size;
-- Total Pizzas Sold by Pizza Category --
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold 
FROM pizza_sale WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 2 
GROUP BY pizza_category ORDER BY Total_Quantity_Sold DESC;
-- Top 5 Pizzas by Revenue --
SELECT pizza_name,SUM(total_price) AS Total_Revenue 
FROM pizza_sale GROUP BY pizza_name ORDER BY Total_Revenue DESC LIMIT 5;
-- Bottom 5 Pizzas by Revenue --
SELECT pizza_name,SUM(total_price) AS Total_Revenue 
FROM pizza_sale GROUP BY pizza_name ORDER BY Total_Revenue ASC LIMIT 5;
-- Top 5 Pizzas by Quantity --
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sale GROUP BY pizza_name ORDER BY Total_Pizza_Sold DESC 
LIMIT 5;
-- Bottom 5 Pizzas by Quantity --
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sale GROUP BY pizza_name ORDER BY Total_Pizza_Sold ASC 
LIMIT 5;
-- Top 5 Pizzas by Total Orders --
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM 
pizza_sale GROUP BY pizza_name ORDER BY Total_Orders DESC LIMIT 5;
-- Bottom 5 Pizzas by Total Orders --
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM 
pizza_sale GROUP BY pizza_name ORDER BY Total_Orders ASC LIMIT 5;