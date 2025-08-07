-- PHASE 1: DATA IMPORT

-- Create the initial table with VARCHAR to handle inconsistent and dirty data.
-- This is a critical first step to ensure the COPY command doesn't fail.
CREATE TABLE cafe_sales (
    transaction_id VARCHAR(50),
    item VARCHAR(50),
    quantity VARCHAR(50),
    price_per_unit VARCHAR(50),
    total_spent VARCHAR(50),
    payment_method VARCHAR(50),
    location VARCHAR(50),
    transaction_date VARCHAR(50)
);

-- PHASE 2: DATA CLEANING

-- Query 1: View all rows to inspect the data before and after cleaning.
SELECT * FROM cafe_sales;

-- Query 2: Get a count of all rows to verify the import was successful (should be 10000).
SELECT COUNT(*) FROM cafe_sales;

-- Query 3: Update the 'total_spent' column. Replace 'ERROR', 'UNKNOWN', and empty strings with NULL.
-- This prepares the column for a data type conversion.
UPDATE cafe_sales
SET total_spent = NULL
WHERE total_spent = 'ERROR' OR total_spent = '' OR total_spent = 'UNKNOWN';

-- Query 4: Show the distinct values in 'total_spent' to confirm the cleaning worked.
SELECT DISTINCT total_spent FROM cafe_sales;

-- Query 5: Show the distinct values in 'item' to check for inconsistencies.
SELECT DISTINCT item FROM cafe_sales;

-- Query 6: Update the 'item' column by setting 'UNKNOWN' to NULL.
UPDATE cafe_sales
SET item = NULL
WHERE item = 'UNKNOWN';

-- Query 7: Update the 'quantity' column by setting 'ERROR', 'UNKNOWN', and empty strings to NULL.
UPDATE cafe_sales
SET quantity = NULL
WHERE quantity = 'ERROR' OR quantity = 'UNKNOWN' OR quantity = '';

-- Query 8: Show the distinct values in 'price_per_unit' to check for inconsistencies.
SELECT DISTINCT price_per_unit FROM cafe_sales;

-- Query 9: Update the 'price_per_unit' column by setting 'ERROR', 'UNKNOWN', and empty strings to NULL.
UPDATE cafe_sales
SET price_per_unit = NULL
WHERE price_per_unit = 'ERROR' OR price_per_unit = 'UNKNOWN' OR price_per_unit = '';

-- Query 10: Update the 'payment_method' column by setting 'ERROR', 'UNKNOWN', and empty strings to NULL.
UPDATE cafe_sales
SET payment_method = NULL
WHERE payment_method = 'ERROR' OR payment_method = 'UNKNOWN' OR payment_method = '';

-- Query 11: Update the 'location' column by setting 'ERROR', 'UNKNOWN', and empty strings to NULL.
UPDATE cafe_sales
SET location = NULL
WHERE location = 'ERROR' OR location = 'UNKNOWN' OR location = '';

-- Query 12: Update the 'transaction_date' column by setting 'ERROR', 'UNKNOWN', and empty strings to NULL.
UPDATE cafe_sales
SET transaction_date = NULL
WHERE transaction_date = 'ERROR' OR transaction_date = 'UNKNOWN' OR transaction_date = '';

-- Query 13: View the data again to see the changes after handling NULLs.
SELECT * FROM cafe_sales;

-- Query 14: Check the current data types of the columns.
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'cafe_sales';

-- Query 15: Convert 'price_per_unit' column to a NUMERIC type.
-- The 'USING' clause is essential for casting a VARCHAR to a numeric type.
ALTER TABLE cafe_sales ALTER COLUMN price_per_unit
TYPE DECIMAL USING price_per_unit::numeric;

-- Query 16: Convert 'total_spent' column to a NUMERIC type.
ALTER TABLE cafe_sales ALTER COLUMN total_spent
TYPE DECIMAL USING total_spent::numeric;

-- Query 17: Convert 'transaction_date' column to a DATE type.
ALTER TABLE cafe_sales ALTER COLUMN transaction_date
TYPE DATE USING transaction_date::date;

-- PHASE 3: DATA ANALYSIS

-- Query 18: Count how many rows still have NULL values in key columns after cleaning.
SELECT COUNT(*)
FROM cafe_sales
WHERE price_per_unit IS NULL OR total_spent IS NULL;

-- Query 19: Calculate total monthly sales and group by month.
SELECT
    DATE_TRUNC('month', transaction_date) AS sales_month,
    SUM(total_spent) AS monthly_sales
FROM
    cafe_sales
GROUP BY
    sales_month
ORDER BY
    sales_month;

-- Query 20: Calculate overall total revenue and average price per unit for the entire dataset.
SELECT
    SUM(total_spent) AS total_revenue,
    AVG(price_per_unit) AS average_price_per_unit
FROM
    cafe_sales;

-- Query 21: Calculate total daily sales and order by date.
SELECT
    transaction_date,
    SUM(total_spent) AS daily_sales
FROM
    cafe_sales
GROUP BY
    transaction_date
ORDER BY
    transaction_date;

-- Query 22: Find the top 5 best-selling items by total revenue.
SELECT
    item,
    SUM(total_spent) AS total_revenue,
    COUNT(transaction_id) AS total_transactions
FROM
    cafe_sales
GROUP BY
    item
ORDER BY
    total_revenue DESC
LIMIT 5;

-- Query 23: Perform a comprehensive check of NULL counts for all columns.
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
    SUM(CASE WHEN item IS NULL THEN 1 ELSE 0 END) AS null_item,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS null_price_per_unit,
    SUM(CASE WHEN total_spent IS NULL THEN 1 ELSE 0 END) AS null_total_spent,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment_method,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS null_loaction,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS null_transaction_date
FROM
    cafe_sales;

-- Query 24: Get a summary of price and total spent values (counts, min, max, avg).
SELECT
    COUNT(price_per_unit) AS count_price,
    MIN(price_per_unit) AS min_price,
    MAX(price_per_unit) AS max_price,
    AVG(price_per_unit) AS avg_price,
    COUNT(total_spent) AS count_spent,
    MIN(total_spent) AS min_spent,
    MAX(total_spent) AS max_spent,
    AVG(total_spent) AS avg_spent
FROM
    cafe_sales;

-- Query 25: Find the top 10 most popular items by transaction count.
SELECT
    item,
    COUNT(*) AS transaction_count
FROM
    cafe_sales
GROUP BY
    item
ORDER BY
    transaction_count DESC
LIMIT 10;

-- Query 26: Find total transactions and revenue by day of the week.
SELECT
    EXTRACT(DOW FROM transaction_date) AS day_of_week_num,
    TO_CHAR(transaction_date, 'Day') AS day_of_week_name,
    COUNT(*) AS total_transactions,
    SUM(total_spent) AS total_revenue
FROM
    cafe_sales
GROUP BY
    day_of_week_num, day_of_week_name
ORDER BY
    day_of_week_num;

-- Query 27: Calculate monthly revenue for each item.
SELECT
    item,
    DATE_TRUNC('month', transaction_date) AS sales_month,
    SUM(total_spent) AS monthly_revenue
FROM
    cafe_sales
GROUP BY
    item, sales_month
ORDER BY
    item, sales_month;
