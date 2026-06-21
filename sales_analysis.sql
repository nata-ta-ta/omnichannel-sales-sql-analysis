-- ==============================================================================
-- Portfolio Project: Omni-Channel Retail Sales Analysis (SQL)
-- Description: Advanced data analysis of online and offline customer behavior.
-- ==============================================================================

--- Q1: Customer Expense Analysis ---
/* Calculate the total online spending for each unique user. 
   Sort the results in descending order of total expenditure. */

SELECT 
    o.user_id, 
    SUM(p.product_price * oi.quantity) AS total_spent
FROM orders_sql_project AS o
JOIN order_items_sql_project AS oi ON oi.order_id = o.order_id
JOIN products_sql_project AS p ON p.product_id = oi.product_id
WHERE o.user_id IS NOT NULL
GROUP BY o.user_id 
ORDER BY total_spent DESC;


--- Q2: Data Integration Across Channels ---
/* Retrieve customer ID, order date, and order ID for all known customers 
   from both online and offline stores combined. 
   Sort by user_id, order_date, and order_id in ascending order. */

SELECT 
    o.user_id, 
    o.order_date, 
    o.order_id AS order_id
FROM orders_sql_project AS o
WHERE o.user_id IS NOT NULL

UNION ALL

SELECT 
    so.user_id, 
    so.order_date, 
    so.store_order_id AS order_id
FROM store_orders AS so
WHERE so.user_id IS NOT NULL
ORDER BY user_id, order_date, order_id;


--- Q3: Cross-Channel Product Search ---
/* Identify IDs of products that were purchased in both online and offline channels. 
   Sort product IDs in ascending order. */

SELECT oi.product_id AS product_id
FROM order_items_sql_project AS oi
INTERSECT
SELECT soi.product_id AS product_id
FROM store_order_items AS soi
ORDER BY product_id;


--- Q4: Active Buyers Identification ---
/* Select IDs of customers who purchased more than 2 units of any product 
   both online and offline. Optimized using EXISTS for performance. */

SELECT DISTINCT so.user_id
FROM store_orders AS so
JOIN store_order_items AS soi ON so.store_order_id = soi.store_order_id
WHERE soi.quantity > 2
  AND so.user_id IS NOT NULL
  AND EXISTS (
      SELECT 1
      FROM orders_sql_project AS o
      JOIN order_items_sql_project AS oi ON o.order_id = oi.order_id
      WHERE oi.quantity > 2 
        AND o.user_id = so.user_id
  )
ORDER BY so.user_id;


--- Q5: Average Online Order Value (AOV) ---
/* Calculate the average order value (AOV) for all online purchases with 'Paid' status. */

WITH indiv_order_totals AS (
    SELECT 
        pmnt.order_id, 
        SUM(pr.product_price * oi.quantity) AS total_amount
    FROM order_items_sql_project AS oi
    JOIN payments_sql_project AS pmnt ON pmnt.order_id = oi.order_id	
    JOIN products_sql_project AS pr ON oi.product_id = pr.product_id
    WHERE pmnt.payment_status = 'Оплачено'
    GROUP BY pmnt.order_id
)
SELECT AVG(total_amount) AS average_paid_check 
FROM indiv_order_totals;


--- Q6: Sales Statistics by Channel ---
/* Generate aggregate purchase statistics for online and offline channels.
   Includes total items sold and total unique orders. Fixed missing GROUP BY. */

SELECT 
    'Online' AS order_type, 
    SUM(quantity) AS total_quantity,  
    COUNT(DISTINCT order_id) AS unique_orders
FROM order_items_sql_project

UNION ALL

SELECT 
    'Offline' AS order_type,  
    SUM(quantity) AS total_quantity, 
    COUNT(DISTINCT store_order_id) AS unique_orders
FROM store_order_items;


--- Q7: Top 3 Most Popular Products ---
/* Find the top 3 most popular products based on the number of unique customers 
   who bought them across both channels (excluding null user IDs). */

WITH global_list AS (
    SELECT oi.product_id, o.user_id AS global_customer_id
    FROM order_items_sql_project AS oi
    JOIN orders_sql_project AS o ON oi.order_id = o.order_id
    WHERE o.user_id IS NOT NULL
    
    UNION -- Automatically removes duplicates (user + product combination)
    
    SELECT soi.product_id, so.user_id AS global_customer_id
    FROM store_order_items AS soi
    JOIN store_orders AS so ON soi.store_order_id = so.store_order_id
    WHERE so.user_id IS NOT NULL
)
SELECT 
    product_id,
    COUNT(global_customer_id) AS unique_customers_count -- Distinct is redundant here due to UNION
FROM global_list
GROUP BY product_id
ORDER BY unique_customers_count DESC
LIMIT 3;


--- Q8: AOV Comparison: Online vs Offline ---
/* Compare the average order value between online and offline channels. 
   Sort results by average check in ascending order. */

WITH global_checks AS (
    SELECT 
        'Online' AS order_type, 
        SUM(p.product_price * oi.quantity) AS total_price 
    FROM order_items_sql_project AS oi
    JOIN products_sql_project AS p ON p.product_id = oi.product_id
    GROUP BY oi.order_id 
    
    UNION ALL
    
    SELECT 
        'Offline' AS order_type, 
        SUM(p.product_price * soi.quantity) AS total_price 
    FROM store_order_items AS soi
    JOIN products_sql_project AS p ON p.product_id = soi.product_id
    GROUP BY soi.store_order_id
)
SELECT 
    order_type, 
    AVG(total_price) AS average_check 
FROM global_checks
GROUP BY order_type
ORDER BY average_check;


--- Q9: High-Value Online Customers ---
/* Identify customers who made at least one online purchase of a product 
   priced higher than the average price of items purchased offline. */

SELECT DISTINCT o.user_id 
FROM orders_sql_project AS o
JOIN order_items_sql_project AS oi ON o.order_id = oi.order_id
JOIN products_sql_project AS p ON p.product_id = oi.product_id
WHERE p.product_price > (
          SELECT AVG(p2.product_price) 
          FROM products_sql_project AS p2
          JOIN store_order_items AS soi ON soi.product_id = p2.product_id
      )
  AND o.user_id IS NOT NULL
ORDER BY o.user_id;


--- Q10: Monthly Analysis of High-Value Orders ---
/* Count the number of unique identified buyers per month who placed orders 
   exceeding the global average check across all channels. Optimized using DRY principle. */

WITH online_orders AS (
    SELECT o.user_id, o.order_date, SUM(p.product_price * oi.quantity) AS total_price
    FROM orders_sql_project AS o
    JOIN order_items_sql_project AS oi ON o.order_id = oi.order_id
    JOIN products_sql_project AS p ON oi.product_id = p.product_id
    WHERE o.user_id IS NOT NULL
    GROUP BY o.user_id, o.order_id, o.order_date
),
offline_orders AS (
    SELECT so.user_id, so.order_date, SUM(p.product_price * soi.quantity) AS total_price
    FROM store_orders AS so
    JOIN store_order_items AS soi ON so.store_order_id = soi.store_order_id
    JOIN products_sql_project AS p ON soi.product_id = p.product_id
    WHERE so.user_id IS NOT NULL
    GROUP BY so.user_id, so.store_order_id, so.order_date
),
all_orders AS (
    SELECT * FROM online_orders
    UNION ALL
    SELECT * FROM offline_orders
),
global_avg AS (
    SELECT AVG(total_price) AS avg_value FROM all_orders
)
SELECT 
    EXTRACT(MONTH FROM order_date) AS order_month, 
    COUNT(DISTINCT user_id) AS buyers_count
FROM all_orders
WHERE total_price > (SELECT avg_value FROM global_avg)
GROUP BY order_month
ORDER BY order_month;
