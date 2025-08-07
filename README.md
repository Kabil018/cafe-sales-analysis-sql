# cafe-sales-analysis-sql

Project Overview
This project is a deep dive into a real-world, "dirty" dataset of cafe sales transactions. The goal was to clean the data from scratch and then use SQL to uncover valuable business insights. This process demonstrates a full data analysis workflow, from preparation to a final report.

The project was an opportunity to showcase key data cleaning skills and then apply a range of SQL techniques to answer questions about sales performance, customer behavior, and product popularity.

The Challenge: A Messy Dataset
The raw dataset had several common data quality issues that needed to be addressed before any analysis could be performed. These included:

Inconsistent data: Values like ERROR and UNKNOWN were present in columns that should have contained only numbers or specific categories.

Missing values: Many rows had empty fields.

Incorrect data types: Numerical columns like total_spent and the transaction_date column were stored as text, which prevented calculations and date-based analysis.

What I Did: The Analysis Journey
Data Cleaning: The first and most important step was to use SQL UPDATE and ALTER TABLE commands to fix the data. This involved replacing inconsistent strings with NULL and converting columns to their proper data types (e.g., DECIMAL for prices, DATE for dates).

Exploratory Data Analysis (EDA): With the data cleaned, I ran a series of queries to explore sales trends and patterns. I used functions like GROUP BY, SUM(), AVG(), and date functions to segment the data.

Key Findings: The analysis provided clear answers to several business questions, including:

Identifying the top-selling items by revenue and transaction count.

Breaking down sales performance by month and day of the week.

Comparing sales across different payment methods and locations (e.g., 'In-store' vs. 'Takeaway').

Skills Demonstrated
This project highlights a number of crucial skills for a data analyst:

Data Cleaning and Transformation: Handling NULL values, replacing inconsistent data, and casting data types.

PostgreSQL: Writing complex queries and using a powerful relational database.

SQL Functions: Extensive use of aggregate functions (SUM, AVG, COUNT), date functions (EXTRACT, DATE_TRUNC, TO_CHAR), and conditional logic (CASE).

Problem-Solving: Starting with a raw, imperfect dataset and turning it into a source of reliable insights.

Files
cafe_sales_analysis.sql: Contains the full SQL script, complete with comments explaining each step from data cleaning to final analysis.

Tools Used
PostgreSQL: The database engine used for all queries.

pgAdmin: The GUI tool used to manage the database and run the SQL script.
