-- Part A: The NULL Hunt
-- 13. Who has NO department assigned yet?
SELECT first_name, last_name FROM new_hires WHERE department IS NULL;
-- Answer: Diane Robles and Jenny Adriano

-- 14. Whose salary is still missing?
SELECT first_name, last_name FROM new_hires WHERE salary IS NULL;
-- Answer: Gio Panganiban

-- 15. Run the three counts
-- SELECT COUNT(*) FROM new_hires;
-- SELECT COUNT(salary) FROM new_hires;
-- SELECT COUNT(department) FROM new_hires;
-- Answer: COUNT(*) counts every row in the table (12), while COUNT(column) ignores NULL values, showing only 11 non-null salaries and 10 non-null departments.

-- 16. The trap, on purpose: run WHERE department = NULL.
SELECT * FROM new_hires WHERE department = NULL;
-- Answer: It returns 0 rows because NULL represents an unknown value, so it cannot equal anything (not even another NULL); you must use IS NULL instead.

-- 17. Run SELECT first_name, salary FROM new_hires ORDER BY salary ASC;
SELECT first_name, salary FROM new_hires ORDER BY salary ASC;
-- Answer: Gio appears first with a blank salary, which tells us that SQLite treats NULL values as the lowest possible value when sorting in ascending order.

-- Part B: HR's First-Week Questions
-- 18. Which new hires are based in Manila or Makati?
SELECT first_name, city FROM new_hires WHERE city IN ('Manila', 'Makati');
-- Answer: There are 5 new hires: Bea, Efren, Hazel, Ivan, Kiko.

-- 19. How many were hired in 2024?
SELECT COUNT(*) FROM new_hires WHERE hire_date LIKE '2024%';
-- Answer: 6 new hires were hired in 2024.

-- 20. Who earns between 25,000 and 30,000?
SELECT first_name, salary FROM new_hires WHERE salary BETWEEN 25000 AND 30000;
-- Answer: Bea, Efren, Faith, Ivan, Kiko, Lara.

-- 21. Top 3 paid new hires?
SELECT first_name, last_name, salary FROM new_hires ORDER BY salary DESC LIMIT 3;
-- Answer: Miko Serrano (34000k), Carlo Mercado (33000k), Kiko Villar (29000k).

-- 22. What cities do the new hires live in — no repeats?
SELECT DISTINCT city FROM new_hires;
-- Answer: Manila, Cebu, Quezon City, Davao, Makati, Baguio. Baguio is NEW to the company compared to our old employees table.

-- Challenge
-- 23. HR asks: "One list please — every new hire with ANY missing information"
SELECT * FROM new_hires WHERE department IS NULL OR salary IS NULL;
-- Answer: Diane Robles, Gio Panganiban, Jenny Adriano.
