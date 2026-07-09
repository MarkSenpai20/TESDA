SELECT *
FROM employees;
-- SELECT COUNT(*) FROM employees
-- SELECT first_name AS FirstName,
-- last_name AS LastName,
-- department AS Department,
-- salary AS Salary  
-- FROM employees;
-- Select first_name || ' ' || last_name AS Name FROM employees;
-- 1. Create sql statement where we can display all data that belongs to the IT deparment only.
-- 2. Create the same statement or  solution to display all data that will display salary whose salary is greater than 40000.  
-- 3. Display all products but limited for those quantity of less than 10.
-- 4. Create a report where you will going to display all employess excluding those who lived in makati.
-- Display all data that belongs to the IT department only.
SELECT * FROM employees
WHERE department = 'IT';
--Display all data that will display salary whose salary is greater than 40000.
SELECT * FROM employees
WHERE salary > 40000;
--Display all products but limited for those quantity of less than 10.
SELECT stock_qty AS Stock,
 * FROM products
WHERE stock_qty < 10;
--Create a report where you will going to display all employees excluding those who lived in Makati.
SELECT * FROM employees 
WHERE city != 'Makati';