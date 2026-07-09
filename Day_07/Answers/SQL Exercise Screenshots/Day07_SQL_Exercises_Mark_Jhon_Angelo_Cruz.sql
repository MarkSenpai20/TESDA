-- Part A, Question 1: Cardiology patients older than 50
SELECT * FROM patients WHERE department = 'Cardiology' AND age > 50;
-- Result: 8 rows returned

-- Part A, Question 2: Cebu City OR Davao City patients
SELECT * FROM patients WHERE city = 'Cebu City' OR city = 'Davao City';
-- Result: 18 rows returned

-- Part A, Question 3: NOT in Pediatrics department
SELECT * FROM patients WHERE NOT department = 'Pediatrics';
-- Result: 42 rows returned

-- Part A, Question 4: Female patients with 'Critical' status
SELECT * FROM patients WHERE gender = 'Female' AND status = 'Critical';
-- Result: 3 rows returned

-- Part A, Question 5: ICU room_type AND billing_amount > 150,000
SELECT * FROM patients WHERE room_type = 'ICU' AND billing_amount > 150000;
-- Result: 9 rows returned

-- Part B, Question 6: age BETWEEN 18 AND 35
SELECT * FROM patients WHERE age BETWEEN 18 AND 35;
-- Result: 12 rows returned

-- Part B, Question 7: admitted in Q1 2025 (admission_date BETWEEN '2025-01-01' AND '2025-03-31')
SELECT * FROM patients WHERE admission_date BETWEEN '2025-01-01' AND '2025-03-31';
-- Result: 17 rows returned

-- Part B, Question 8: department IN ('Cardiology', 'Oncology', 'Neurology')
SELECT * FROM patients WHERE department IN ('Cardiology', 'Oncology', 'Neurology');
-- Result: 23 rows returned

-- Part B, Question 9: diagnosis starts with 'Heart'
SELECT * FROM patients WHERE diagnosis LIKE 'Heart%';
-- Result: 6 rows returned

-- Part B, Question 10: doctor_name contains 'Tan'
SELECT * FROM patients WHERE doctor_name LIKE '%Tan%';
-- Result: 13 rows returned

-- Part C, Question 11: sorted by billing_amount highest to lowest (DESC)
SELECT * FROM patients ORDER BY billing_amount DESC;
-- Result: 50 rows returned

-- Part C, Question 12: TOP 5 most expensive admissions
SELECT * FROM patients ORDER BY billing_amount DESC LIMIT 5;
-- Result: 5 rows returned

-- Part C, Question 13: Pediatrics patients sorted by admission_date oldest first (ASC)
SELECT * FROM patients WHERE department = 'Pediatrics' ORDER BY admission_date ASC;
-- Result: 8 rows returned

-- Part C, Question 14: 10 most recent admissions
SELECT * FROM patients ORDER BY admission_date DESC LIMIT 10;
-- Result: 10 rows returned

-- Part C, Question 15: Metro Manila cities, sorted by department A-Z, then billing_amount highest first
SELECT * FROM patients WHERE city IN ('Manila', 'Makati', 'Quezon City', 'Pasig') ORDER BY department ASC, billing_amount DESC;
-- Result: 28 rows returned

