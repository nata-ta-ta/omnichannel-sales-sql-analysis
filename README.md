# Omni-Channel Retail Sales Analysis (SQL)

This project focuses on analyzing customer behavior and sales performance across two main distribution channels: Online Store and Brick-and-Mortar (Offline) Stores. Using advanced SQL techniques, the analysis provides data-driven insights into customer spending habits, cross-channel interactions, Average Order Value (AOV), and seasonal purchase trends.

The core objective is to help the business understand user engagement, optimize marketing strategies, and identify high-value customer segments.

## Tech Stack and Key SQL Concepts Used

* **Database Management:** PostgreSQL / Standard SQL
* **Key Techniques:**
  * Complex Data Joins (INNER JOIN, LEFT JOIN)
  * Data Aggregation and Filtering (GROUP BY, HAVING)
  * Subqueries and Nested Queries (EXISTS, IN)
  * Common Table Expressions (CTEs) for modular and clean code
  * Set Operations (UNION ALL, INTERSECT, UNION)
  * Date/Time Data Manipulation (EXTRACT)

## Database Schema Context

The analysis is performed on the following interconnected tables:

* `orders_sql_project` & `order_items_sql_project` (Online sales data)
* `store_orders` & `store_order_items` (Offline retail sales data)
* `products_sql_project` (Product directory containing prices)
* `payments_sql_project` (Payment statuses for online transactions)

## Analytical Tasks Covered

The comprehensive SQL script inside this repository answers 10 critical business questions:

1. **User Expense Analysis:** Calculating total online spending per user.
2. **Data Integration Across Channels:** Merging online and offline customer transactions.
3. **Cross-Channel Product Search:** Identifying products purchased in both channels.
4. **Active Buyers Identification:** Finding customers buying bulk (>2 units) everywhere.
5. **Average Online Order Value (AOV):** Computing AOV specifically for successful (Paid) orders.
6. **Sales Statistics by Channel:** Comparing total quantities and unique order volumes.
7. **Top 3 Most Popular Products:** Finding items with the highest unique customer reach.
8. **AOV Comparison:** Evaluating financial performance (Online vs. Offline).
9. **High-Value Online Customers:** Segmenting online buyers who beat offline price benchmarks.
10. **Monthly Trend Analysis:** Tracking the influx of high-value shoppers by month.

## Key Business Takeaways

* **Channel Performance:** Helps management decide where to allocate advertising budget (Online platform scalability vs. Offline retail overheads).
* **Customer Loyalty:** Identifying cross-channel users allows the creation of unified omnichannel loyalty programs.
