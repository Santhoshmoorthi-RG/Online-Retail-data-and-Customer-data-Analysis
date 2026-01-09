-- data profiling

-- row count checking for how many rows in the dataset

SELECT COUNT(*) FROM retail_analysis.online_retail_raw;
SELECT COUNT( DISTINCT InvoiceNo) FROM retail_analysis.online_retail_raw;

-- checking the table and its data types

DESCRIBE retail_analysis.online_retail_raw;

/* data range 

SELECT MIN(InvoiceDate) as start_date, MAX(InvoiceDate) as end_date
FROM retail_analysis.online_retail_raw;
*/

SELECT
    MIN(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')) AS start_date,
    MAX(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')) AS end_date
FROM online_retail_raw;

SELECT InvoiceDate FROM retail_analysis.online_retail_raw LIMIT 10;

-- looking for null values

SELECT
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS null_invoice,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS null_stockcode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS null_description,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS null_unitprice,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_country
FROM retail_analysis.online_retail_raw;

-- looking for product returns and pricing error

SELECT SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity FROM retail_analysis.online_retail_raw; 

SELECT SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_unitprice FROM retail_analysis.online_retail_raw;

-- looking for distinct customer and products

SELECT COUNT(DISTINCT CustomerID) FROM retail_analysis.online_retail_raw;

SELECT COUNT(DISTINCT StockCode) FROM retail_analysis.online_retail_raw;
