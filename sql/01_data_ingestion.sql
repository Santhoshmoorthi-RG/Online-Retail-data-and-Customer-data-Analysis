-- created a table 

CREATE TABLE online_retail_raw (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate VARCHAR(30),
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(100)
);
-- checking where my sql import directory is
SHOW VARIABLES LIKE 'secure_file_priv';

-- loading data into tables using load datainfile function because it is faster than table import data wizard.

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/online_retail.csv'
INTO TABLE online_retail_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dummy, InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country);

-- checcking for all databases.

Show databases;

-- Created table in wrong databases so now creating table in right database.

CREATE TABLE retail_analysis.online_retail_raw AS
SELECT * from world_layoff.online_retail_raw;

-- cross-verfying all data are correctly copied or not

SELECT COUNT(*) FROM retail_analysis.online_retail_raw;
SELECT COUNT(*) FROM world_layoff.online_retail_raw;


