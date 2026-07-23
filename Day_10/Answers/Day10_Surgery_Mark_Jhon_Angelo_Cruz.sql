-- ============================================================
-- Day 10: Activity 2 — The Surgery
-- Student: Mark Jhon Angelo Cruz
-- ============================================================

-- Step 0 — Rule 1: Backup
CREATE TABLE customers_backup AS SELECT * FROM customers;
-- Verification:
SELECT COUNT(*) FROM customers_backup;
-- Result: 28 rows (matches the original table exactly)

-- ============================================================
-- Step 1 — Spaces and Casing
-- ============================================================

-- 8. TRIM all text columns
-- (No WHERE clause needed because trimming a clean value changes nothing;
--  it's a safe, idempotent operation that only removes invisible spaces.)
UPDATE customers
SET full_name = TRIM(full_name),
    city = TRIM(city),
    email = TRIM(email);

-- 9. Lowercase every email
UPDATE customers SET email = LOWER(email);

-- ============================================================
-- Step 2 — Standardize the Cities (Rule 2: Preview before every UPDATE)
-- ============================================================

-- 10. Preview then fix each city variant

-- Manila
SELECT * FROM customers WHERE LOWER(city) = 'manila';
UPDATE customers SET city = 'Manila' WHERE LOWER(city) = 'manila';

-- Quezon City (including 'qc')
SELECT * FROM customers WHERE LOWER(city) IN ('quezon city', 'qc');
UPDATE customers SET city = 'Quezon City' WHERE LOWER(city) IN ('quezon city', 'qc');

-- Cebu
SELECT * FROM customers WHERE LOWER(city) = 'cebu';
UPDATE customers SET city = 'Cebu' WHERE LOWER(city) = 'cebu';

-- Davao
SELECT * FROM customers WHERE LOWER(city) = 'davao';
UPDATE customers SET city = 'Davao' WHERE LOWER(city) = 'davao';

-- Makati
SELECT * FROM customers WHERE LOWER(city) = 'makati';
UPDATE customers SET city = 'Makati' WHERE LOWER(city) = 'makati';

-- 11. Verify: exactly 5 clean city names remain
SELECT DISTINCT city FROM customers;
-- Result: Manila, Quezon City, Cebu, Davao, Makati

-- ============================================================
-- Step 3 — Free the Numbers
-- ============================================================

-- 12. Remove commas from monthly_spend
UPDATE customers SET monthly_spend = REPLACE(monthly_spend, ',', '');

-- 13. Verify the new SUM
SELECT SUM(CAST(monthly_spend AS INTEGER)) FROM customers;
-- Result: 54250
-- This is much bigger than the Activity 1 "lie" of 4542, but it is STILL not the final truth.
-- Why? Because duplicate rows (IDs 103, 110, 117) are still in the table, inflating the total
-- by counting their spend twice.

-- ============================================================
-- Step 4 — Deduplicate by Creation
-- ============================================================

-- 14. Create the clean table
CREATE TABLE customers_clean AS SELECT DISTINCT * FROM customers;

SELECT COUNT(*) FROM customers_clean;
-- Result: 25 rows (down from 28)

SELECT SUM(CAST(monthly_spend AS INTEGER)) FROM customers_clean;
-- Result: 50200
-- This NOW matches Day 9's Power Query total! The duplicates were adding
-- extra spend amounts (Liza's 2300, Ramon's 600, Faye's 1150) on top of the real total.

-- 15. Rule 4 check: compare all three tables
SELECT COUNT(*) FROM customers;
-- Result: 28 (the dirty table after cleaning but still has duplicates)

SELECT COUNT(*) FROM customers_backup;
-- Result: 28 (untouched original — our safety net)

SELECT COUNT(*) FROM customers_clean;
-- Result: 25 (the final, pristine, deduplicated table ready for reporting)
