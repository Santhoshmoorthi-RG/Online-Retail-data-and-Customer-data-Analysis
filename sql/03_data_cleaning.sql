
-- checking for return order

SELECT COUNT(*) AS negative_qty 
FROM retail_analysis.online_retail_raw 
WHERE Quantity <= 0;

-- created a new table for clean data

CREATE TABLE online_retail_clean AS
SELECT *
FROM online_retail_raw
WHERE Quantity > 0 AND UnitPrice > 0;

Select * from online_retail_clean;

SELECT count(*) from online_retail_clean;

-- alter table and updating table with datetime.

ALTER TABLE online_retail_clean
ADD COLUMN InvoiceDateTime DATETIME;

UPDATE online_retail_clean
SET InvoiceDateTime = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');

Select * from online_retail_clean;

-- deleting the data errors 

DELETE FROM online_retail_clean
WHERE UnitPrice <= 0;

Select count(*) from online_retail_clean where UnitPrice <= 0;

-- Checking for duplicates.

CREATE TABLE online_retail_clean_new AS
WITH ranked_rows AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY InvoiceNo, StockCode, InvoiceDateTime, CustomerID
               ORDER BY CustomerID
           ) AS row_num
    FROM online_retail_clean
)
SELECT *
FROM ranked_rows
WHERE row_num = 1;

SELECT * FROM online_retail_clean_new;
SELECT COUNT(*) FROM online_retail_clean_new;
Select count(*) from online_retail_clean;


-- checking for data integrity by grouping the columns.

SELECT InvoiceNo, StockCode, InvoiceDate, COUNT(DISTINCT CustomerID) AS customer_count
FROM online_retail_raw
GROUP BY InvoiceNo, StockCode, InvoiceDate
HAVING COUNT(*) > 1
   AND COUNT(DISTINCT CustomerID) > 1;

