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
SELECT SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS cancelled_quantity FROM retail_analysis.online_retail_raw;

SELECT SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_unitprice FROM retail_analysis.online_retail_raw;
SELECT SUM(CASE WHEN UnitPrice = 0 THEN 1 ELSE 0 END) AS invalid_unitprice FROM retail_analysis.online_retail_raw;

-- looking for distinct customer and products

SELECT COUNT(DISTINCT CustomerID) FROM retail_analysis.online_retail_raw;

SELECT COUNT(DISTINCT StockCode) FROM retail_analysis.online_retail_raw;
SELECT COUNT(DISTINCT Country) FROM retail_analysis.online_retail_raw;

-- looking for duplicates.

SELECT
    InvoiceNo,
    StockCode,
    InvoiceDate,
    COUNT(*) AS cnt
FROM online_retail_raw
GROUP BY InvoiceNo, StockCode, InvoiceDate
HAVING COUNT(*) > 1
LIMIT 10; 

-- calculating total duplicate rows

with duplicate_rows as(
SELECT COUNT(*) as cnt FROM retail_analysis.online_retail_raw 
GROUP BY InvoiceNo,StockCode,InvoiceDate 
HAVING COUNT(*) >1
)
 SELECT SUM(cnt-1) as total_duplicate_rows FROM duplicate_rows;


-- distribution .

SELECT 
	MIN(Quantity) as Min_qty,
    MAX(Quantity) as Max_qty,
    AVG(Quantity) as avg_qty,
    STDDEV(Quantity) as Std_qty
FROM retail_analysis.online_retail_raw;

SELECT
    Quantity,
    COUNT(*) AS frequency
FROM online_retail_raw
GROUP BY Quantity
ORDER BY frequency DESC
LIMIT 10;

-- distribution in unit price
SELECT
    MIN(UnitPrice) AS min_price,
    MAX(UnitPrice) AS max_price,
    AVG(UnitPrice) AS avg_price,
    STDDEV(UnitPrice) AS stddev_price
FROM online_retail_raw;

SELECT
    UnitPrice,
    COUNT(*) AS frequency
FROM online_retail_raw
GROUP BY UnitPrice
ORDER BY frequency DESC
LIMIT 10;

-- distribution on invoice _value(qty*unitprice)
SELECT
    MIN(invoice_value) AS min_value,
    MAX(invoice_value) AS max_value,
    AVG(invoice_value) AS avg_value
FROM (
    SELECT
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS invoice_value
    FROM online_retail_raw
    GROUP BY InvoiceNo
) t;


-- distribution on order per invoice
SELECT
    MIN(items) AS min_items,
    MAX(items) AS max_items,
    AVG(items) AS avg_items
FROM (
    SELECT
        InvoiceNo,
        COUNT(*) AS items
    FROM online_retail_raw
    GROUP BY InvoiceNo
) t;

-- distribution on  sales per customer
SELECT
    MIN(total_sales),
    MAX(total_sales),
    AVG(total_sales)
FROM (
    SELECT
        CustomerID,
        SUM(Quantity * UnitPrice) AS total_sales
    FROM online_retail_raw
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) t;

-- distribution on country
SELECT
    Country,
    SUM(Quantity * UnitPrice) AS revenue
FROM online_retail_raw
GROUP BY Country
ORDER BY revenue DESC;

-- distribution on year and month

SELECT
    YEAR(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')) AS year,
    MONTH(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i')) AS month,
    SUM(Quantity * UnitPrice) AS revenue
FROM online_retail_raw
GROUP BY year, month
ORDER BY year, month;


