 Question 1  Achieving 1NF (First Normal Form)

-- Convert multi-valued Products column into single rows per product (1NF)
-- Assumes use of MySQL 8+ (for JSON_TABLE). Modify accordingly for other DBMS.
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail,
    JSON_TABLE(
        CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
        '$[*]' COLUMNS (value VARCHAR(100) PATH '$')
    ) AS ProductList;
 --This ensures each product appears in a separate row, thus conforming to 1NF by eliminating multi-valued columns.




Question 2  Achieving 2NF (Second Normal Form)

-- Step 1: Create a table for Orders with no partial dependency
-- CustomerName is moved to a separate table to eliminate partial dependency on OrderID
SELECT DISTINCT 
    OrderID,
    CustomerName
FROM 
    OrderDetails;

-- Step 2: Create a table for OrderItems with full dependency on the composite key
-- This table maintains dependency on the full primary key (OrderID + Product)
SELECT 
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;
 --This separates customer data from product data, achieving 2NF by ensuring that non-key columns depend on the full primary key only.


