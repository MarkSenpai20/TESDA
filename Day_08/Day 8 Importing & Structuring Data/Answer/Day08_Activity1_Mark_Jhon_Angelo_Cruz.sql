-- Activity 1: Build & Fill a Table
-- 1. Create interns table
CREATE TABLE interns (
    intern_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    school TEXT,
    start_date TEXT
);

-- 2. Insert 3 interns
INSERT INTO interns (intern_id, full_name, school, start_date) VALUES 
(1, 'Paula Vergara', 'PUP', '2024-06-10'),
(2, 'Rico Dizon', 'UST', '2024-06-10'),
(3, 'Sam Aguilar', NULL, NULL);

-- 3. Verify
-- SELECT COUNT(*) FROM interns;  -- Result: 3
-- SELECT * FROM interns WHERE school IS NOT NULL; -- Result: Paula Vergara, Rico Dizon

-- 4. Error Message for NOT NULL
-- INSERT INTO interns (intern_id, full_name, school, start_date) VALUES (4, NULL, 'UP', '2024-06-10');
-- Exact Error Message: NOT NULL constraint failed: interns.full_name
