# Online-Retail-data-and-Customer-data-Analysis

In this project, we ingest and clean a large online retail transaction dataset and perform sales, product, customer, and geographical analysis using SQL. By transforming raw transactional data into analytics-ready tables, we uncover revenue trends, customer behavior patterns, and product performance insights that can support business decision-making such as inventory planning, customer segmentation, and regional strategy.

Data profiling:

1.first calculating total no .of rows to  understand the data.(541909)
2.then calculated distinct invoice to understand the total no.of orders.(25900)
3.then used describe function to check the data types of the data in the table.
4.with the help of case function checked for the null numbers in each column.(no null values in all column checked)
5.again with case function looked for order return by fixing quantity≤0 because quantity>0 means the item is sold if otherwise then it is returned or cancelled.(10624)
6.again with case function looked for unit price value by fixing unitprice ≤ 0 because unitprice>0 means the product have some value if otherwise the product doesnt have value or we are  paying customers to take the product which is not possible in real life scenario. (2521) that means data error.
7.checked for unique customer id to find howmany customers do  we have.(4373)
8checked for unique stock id to find howmany products are we selling.(3958)
9.checked for unique country to  understand the business.
10.With help of cte function checked for duplicate rows by grouping invoiceno,invoicedate and stockcode .(10679)
