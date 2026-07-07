-- 9. Show ALL columns and rows of the employees table. How many rows are there?
SELECT *
FROM employees;
-- 10. Show only first_name, last_name, and department for all employees.
SELECT first_name,
    last_name,
    department
FROM employees;
-- 11. Show only product_name and price for all products.
SELECT product_name,
    price
FROM products;
-- 12. Which employees work in Manila? (Show first_name, last_name, city.) How many are there?
SELECT first_name,
    last_name,
    city
FROM employees
WHERE city = 'Manila';
-- 13. Which employees earn MORE than P40,000? (Show first_name and salary.) How many?
SELECT first_name,
    salary
FROM employees
WHERE salary > 40000;
-- 14. List everyone in the IT department. (Show first_name and position.)
SELECT first_name,
    position
FROM employees
WHERE department = 'IT';
-- 15. Which products cost P1,000 or LESS? (Show product_name and price.)
SELECT product_name,
    price
FROM products
WHERE price <= 1000;
-- 16. Which products have FEWER than 10 units in stock? (Show product_name and stock_qty.)
SELECT product_name,
    stock_qty
FROM products
WHERE stock_qty < 10;
-- 17. count how many employees do NOT work in Makati.
SELECT COUNT(*)
FROM employees
WHERE city <> 'Makati';
-- 18. Managers earn P50,000 or more in this company. Write ONE query that shows first_name, last_name, and salary of everyone earning at least P50,000.
SELECT first_name,
    last_name,
    salary
FROM employees
WHERE salary >= 50000;