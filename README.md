\# Omni-Channel Retail Sales Analysis (SQL)

This project focuses on analyzing customer behavior and sales performance across two main distribution channels: \*\*Online Store\*\* and \*\*Brick-and-Mortar (Offline) Stores\*\*. Using advanced SQL techniques, the analysis provides data-driven insights into customer spending habits, cross-channel interactions, Average Order Value (AOV), and seasonal purchase trends.


The core objective is to help the business understand user engagement, optimize marketing strategies, and identify high-value customer segments.


\## 🛠️ Tech Stack \& Key SQL Concepts Used

\* \*\*Database Management:\*\* PostgreSQL / Standard SQL

\* \*\*Key Techniques:\*\*

&#x20; \* Complex Data Joins (`INNER JOIN`, `LEFT JOIN`)

&#x20; \* Data Aggregation \& Filtering (`GROUP BY`, `HAVING`)

&#x20; \* Subqueries \& Nested Queries (`EXISTS`, `IN`)

&#x20; \* Common Table Expressions (CTEs) for modular and clean code

&#x20; \* Set Operations (`UNION ALL`, `INTERSECT`, `UNION`)

&#x20; \* Date/Time Data Manipulation (`EXTRACT`)



\## 📊 Database Schema (Context)

The analysis is performed on the following interconnected tables:

\* `orders\_sql\_project` \& `order\_items\_sql\_project` (Online sales data)

\* `store\_orders` \& `store\_order\_items` (Offline retail sales data)

\* `products\_sql\_project` (Product directory containing prices)

\* `payments\_sql\_project` (Payment statuses for online transactions)



\## 🔍 Analytical Tasks Covered

The SQL script answers 10 critical business questions:

1\. \*\*User Expense Analysis:\*\* Calculating total online spending per user.

2\. \*\*Data Integration Across Channels:\*\* Merging online and offline customer transactions.

3\. \*\*Cross-Channel Product Search:\*\* Identifying products purchased in both channels.

4\. \*\*Active Buyers Identification:\*\* Finding customers buying bulk (>2 units) everywhere.

5\. \*\*Average Online Order Value (AOV):\*\* Computing AOV specifically for successful (Paid) orders.

6\. \*\*Sales Statistics by Channel:\*\* Comparing total quantities and unique order volumes.

7\. \*\*Top 3 Most Popular Products:\*\* Finding items with the highest unique customer reach.

8\. \*\*AOV Comparison:\*\* Evaluating financial performance (Online vs. Offline).

9\. \*\*High-Value Online Customers:\*\* Segmenting online buyers who beat offline price benchmarks.

10\. \*\*Monthly Trend Analysis:\*\* Tracking the influx of high-value shoppers by month.




\## 💡 Key Business Takeaways (Example Conclusions)

\* \*Channel Performance:\* Helps management decide where to allocate advertising budget (Online platform scalability vs. Offline retail overheads).

\* \*Customer Loyalty:\* Identifying cross-channel users allows the creation of unified omnichannel loyalty programs.

