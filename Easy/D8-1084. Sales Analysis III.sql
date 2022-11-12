-- 1084. Sales Analysis III

-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- | unit_price   | int     |
-- +--------------+---------+
-- product_id is the primary key of this table.
-- Each row of this table indicates the name and the price of each product.
-- Table: Sales

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | seller_id   | int     |
-- | product_id  | int     |
-- | buyer_id    | int     |
-- | sale_date   | date    |
-- | quantity    | int     |
-- | price       | int     |
-- +-------------+---------+
-- This table has no primary key, it can have repeated rows.
-- product_id is a foreign key to the Product table.
-- Each row of this table contains some information about one sale.
 

-- Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Product table:
-- +------------+--------------+------------+
-- | product_id | product_name | unit_price |
-- +------------+--------------+------------+
-- | 1          | S8           | 1000       |
-- | 2          | G4           | 800        |
-- | 3          | iPhone       | 1400       |
-- +------------+--------------+------------+
-- Sales table:
-- +-----------+------------+----------+------------+----------+-------+
-- | seller_id | product_id | buyer_id | sale_date  | quantity | price |
-- +-----------+------------+----------+------------+----------+-------+
-- | 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
-- | 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
-- | 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
-- | 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
-- +-----------+------------+----------+------------+----------+-------+
-- Output: 
-- +-------------+--------------+
-- | product_id  | product_name |
-- +-------------+--------------+
-- | 1           | S8           |
-- +-------------+--------------+
-- Explanation: 
-- The product with id 1 was only sold in the spring of 2019.
-- The product with id 2 was sold in the spring of 2019 but was also sold after the spring of 2019.
-- The product with id 3 was sold after spring 2019.
-- We return only product 1 as it is the product that was only sold in the spring of 2019.

 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution
Select distinct p.product_id, p.product_name 
from Product as p
Left Join Sales as s
on p.product_id = s.product_id
where s.sale_date between "2019-01-01" and "2019-03-31" 
and p.product_id Not in 
(Select product_id
from Sales
WHERE sale_date > '2019-03-31'
OR sale_date < '2019-01-01');
 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
SELECT product_id, product_name
FROM Sales 
JOIN Product 
Using(product_id)
GROUP BY product_id
HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31' 


-- # Write your MySQL query statement below
WITH cte AS
(SELECT product_id FROM Sales
WHERE sale_date > '2019-03-31'
OR sale_date < '2019-01-01')

SELECT DISTINCT s.product_id , p.product_name
FROM Sales s
LEFT JOIN Product p
ON s.product_id=p.product_id  
WHERE s.product_id NOT 
IN(SELECT product_id FROM cte); 


-- # Write your MySQL query statement below
WITH rejected_ids AS (
    SELECT s.product_id
    FROM sales s
    WHERE s.sale_date NOT BETWEEN DATE('2019-01-01') AND DATE('2019-03-31')
)
SELECT DISTINCT p.product_id, p.product_name
FROM product p
INNER JOIN sales s ON s.product_id = p.product_id
LEFT JOIN rejected_ids r ON r.product_id = p.product_id
WHERE s.sale_date BETWEEN DATE('2019-01-01') AND DATE('2019-03-31') AND r.product_id IS NULL