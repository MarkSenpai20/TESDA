-- Exercise 1 - INSERT INTO
-- Create a new table called promo_signups
CREATE TABLE IF NOT EXISTS promo_signups (
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    city TEXT,
    region TEXT,
    signup_date TEXT,
    total_orders INTEGER,
    total_spent REAL
);
-- Insert multiple rows in promo_signups
INSERT INTO promo_signups (
        first_name,
        last_name,
        email,
        city,
        region,
        signup_date,
        total_orders,
        total_spent
    )
VALUES (
        'Lily',
        'Chua',
        'lily.chua@email.com',
        'Manila',
        'NCR',
        '2025-01-05',
        2,
        5600
    ),
    (
        'James',
        'Lim',
        'james.lim@email.com',
        'Quezon City',
        'NCR',
        '2025-02-15',
        1,
        850
    );
-- Select all rows in promo_signups
SELECT *
FROM promo_signups;
-- EXERCISE 2
-- Use WHERE (AND / OR / IN)
SELECT customer_name,
    product_name,
    total_amount,
    category
FROM sales
WHERE region = 'Visayas'
    AND total_amount < 5000
    AND category IN ('Accessories', 'Peripherals');
-- EXERCISE 3
-- Use BETWEEN / date ranges
SELECT sale_date,
    customer_name,
    product_name,
    total_amount
FROM sales
WHERE sale_date >= '2025-04-01'
    AND sale_date < '2025-07-01'
ORDER BY sale_date DESC;
-- EXERCISE 4
-- Use IN / NOT IN
SELECT first_name,
    last_name,
    email,
    city
FROM customers
WHERE city NOT IN ('Manila', 'Makati', 'Pasig');
-- EXERCISE 5
-- Use LIKE (wildcards)
SELECT product_name,
    category,
    total_amount
FROM sales
WHERE product_name LIKE '%Pro';
-- Exercise 6 - ORDER BY and LIMIT
-- SELECT first_name, last_name, total_spent
SELECT first_name,
    last_name,
    total_spent
FROM customers
ORDER BY total_spent ASC,
    customer_id ASC
LIMIT 5;
-- Exercise 7 - GROUP BY
-- SELECT category, COUNT(sale_id) AS num_sales, AVG(total_amount) AS avg_sale_amount
SELECT category,
    COUNT(sale_id) AS num_sales,
    AVG(total_amount) AS avg_sale_amount
FROM sales
GROUP BY category
ORDER BY avg_sale_amount DESC;
-- Exercise 8 - HAVING
SELECT region,
    SUM(total_amount) AS electronics_revenue
FROM sales
WHERE category = 'Electronics'
GROUP BY region
HAVING SUM(total_amount) > 100000;
-- Exercise 9 - JOIN
SELECT c.first_name,
    c.last_name,
    COUNT(s.sale_id) AS purchase_count
FROM customers c
    LEFT JOIN sales s ON s.customer_name = c.first_name || ' ' || c.last_name
GROUP BY c.customer_id,
    c.first_name,
    c.last_name
ORDER BY purchase_count DESC;
-- Exercise 10 - CASE WHEN
SELECT item_name,
    quantity_on_hand,
    CASE
        WHEN quantity_on_hand = 0 THEN 'Out of Stock'
        WHEN quantity_on_hand <= 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM inventory;
-- Exercise 11 - COALESCE
SELECT item_name,
    COALESCE(unit_cost, 0) AS unit_cost,
    COALESCE(unit_cost, 0) * quantity_on_hand AS inventory_value
FROM inventory;
-- Exercise 12 - UPDATE / DELETE
-- Find items with unit_cost >= 10000
SELECT item_name,
    unit_cost
FROM inventory
WHERE unit_cost >= 10000;
-- Update these items by increasing unit_cost by 10%
UPDATE inventory
SET unit_cost = unit_cost * 1.10
WHERE unit_cost >= 10000;
-- Select updated items to verify
SELECT item_name,
    unit_cost
FROM inventory
WHERE unit_cost >= 10000;
-- Exercise 13 - ALTER TABLE
-- Add membership_tier column to customers table with default value 'Standard'
ALTER TABLE customers
ADD COLUMN membership_tier TEXT DEFAULT 'Standard';
-- Select first 5 customers to verify
SELECT first_name,
    last_name,
    membership_tier
FROM customers
LIMIT 5;