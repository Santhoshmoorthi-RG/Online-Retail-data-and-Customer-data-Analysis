# Building an Analytics-Ready Online Retail Data Pipeline Using SQL

## Project Overview

This project focuses on building an analytics-ready data foundation from raw online retail transaction data using SQL. The objective is to ingest, profile, and clean transactional data to ensure high data quality and prepare it for downstream business analysis such as sales performance, customer behavior, product analysis, and geographical insights.

The cleaned dataset supports reliable decision-making related to inventory planning, customer segmentation, and regional business strategy.

---

## Data Pipeline Architecture

Raw Retail Dataset → online_retail_raw → online_retail_clean_new


---

## Data Ingestion

- Imported the raw online retail transaction dataset into a SQL database  
- Created a staging table to store raw transactional records  
- Ensured all columns were loaded with appropriate initial data types  

---

## Data Profiling

Data profiling was performed to understand the structure, quality, and issues in the dataset before cleaning.

### Profiling Checks Performed

- Calculated total number of rows to understand dataset size  
  - **Total records:** 541,909  

- Calculated distinct invoice numbers to identify total orders  
  - **Total invoices:** 25,900  

- Inspected column data types using schema/describe queries  

- Checked for NULL values in each column using conditional logic  
  - **Result:** No NULL values in the checked columns  

- Identified returned or cancelled orders by checking `quantity ≤ 0`  
  - **Returned/cancelled records:** 10,624  

- Identified invalid pricing records by checking `unit_price ≤ 0`  
  - **Invalid price records:** 2,521 (data errors)  

- Calculated distinct customer IDs to understand customer base  
  - **Total customers:** 4,373  

- Calculated distinct stock codes to understand product variety  
  - **Total products:** 3,958  

- Identified unique countries to understand geographical presence  

- Detected duplicate records using CTEs by grouping on  
  `invoice_no`, `invoice_date`, and `stock_code`  
  - **Duplicate rows identified:** 10,679  

---

## Data Cleaning & Transformation

Based on profiling insights, the following cleaning steps were applied:

- Created a new column with the correct datetime data type for invoice timestamps  
- Removed returned and cancelled transactions where `quantity ≤ 0`  
- Removed records with invalid pricing where `unit_price ≤ 0`  
- Removed duplicate rows to avoid double-counting transactions  
- Validated that each invoice is uniquely associated with a single customer to ensure transactional integrity  
- Stored the cleaned and validated data in a new table: **`online_retail_clean_new`**

---

## Final Output

- **`online_retail_clean_new`**  
  A clean, reliable, analytics-ready table suitable for:
  - Business performance analysis  
  - Customer behavior analysis  
  - A/B testing  
  - Customer segmentation  
  - Pricing and seasonality analysis  

---

## Skills Demonstrated

- SQL-based data ingestion  
- Data profiling and quality auditing  
- Data cleaning and transformation  
- Analytics-ready schema design  
- Real-world transactional data handling  

---

## Next Steps

The cleaned dataset will be used in future projects for:

- Retail business performance analysis  
- Customer behavior A/B testing  
- Customer segmentation and retention analysis  
- Pricing and seasonal trend analysis  
