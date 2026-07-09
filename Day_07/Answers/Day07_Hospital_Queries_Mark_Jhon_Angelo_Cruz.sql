-- Scenario 1: ICU Critical Care Report (8 points)
-- The medical director needs an urgent report of all patients currently in the ICU whose status is 'Critical'.
-- Show their patient_name, age, diagnosis, doctor_name, and billing_amount. Sort by billing_amount from highest to lowest.
SELECT patient_name,
    age,
    diagnosis,
    doctor_name,
    billing_amount
FROM patients
WHERE room_type = 'ICU'
    AND status = 'Critical'
ORDER BY billing_amount DESC;
-- Interpretation: This query filters for the most at-risk patients who are both in the ICU and marked Critical, ordering them by financial impact. The results help the medical director immediately identify the most urgent and costly ICU cases.
-- Scenario 2: Senior Citizen Care Analysis (8 points)
-- The Geriatrics committee is studying admissions of senior patients. Show all patients whose age is BETWEEN 60 AND 75 AND whose department is in ('Cardiology', 'Oncology', 'Neurology').
-- Show patient_name, age, department, diagnosis, and status. Sort by age (oldest first).
SELECT patient_name,
    age,
    department,
    diagnosis,
    status
FROM patients
WHERE age BETWEEN 60 AND 75
    AND department IN ('Cardiology', 'Oncology', 'Neurology')
ORDER BY age DESC;
-- Interpretation: This extracts senior patients within three highly specialized departments, ordered by oldest age first. It allows the Geriatrics committee to review conditions and statuses of their most elderly and vulnerable admissions.
-- Scenario 3: High-Value Billing Review (8 points)
-- The finance department needs to flag high-value admissions for insurance audit. Show all patients whose billing_amount is BETWEEN 100,000 AND 250,000 AND whose room_type is 'Private' OR 'ICU'.
-- Show patient_name, room_type, billing_amount, and department. Sort by billing_amount (highest first), then LIMIT the results to the TOP 10.
SELECT patient_name,
    room_type,
    billing_amount,
    department
FROM patients
WHERE billing_amount BETWEEN 100000 AND 250000
    AND (
        room_type = 'Private'
        OR room_type = 'ICU'
    )
ORDER BY billing_amount DESC
LIMIT 10;
-- Interpretation: The query strictly captures the top 10 most expensive billing accounts within the target range for Private/ICU rooms. Finance can use this targeted list to begin their high-priority insurance audits without being overwhelmed by data.
-- Scenario 4: Diagnosis Pattern Search (8 points)
-- A research team is studying cancer cases across the hospital. Search the patients table for all patients whose diagnosis contains the word 'Cancer' (use LIKE).
-- Show patient_name, age, gender, diagnosis, and billing_amount. Sort the results by age (youngest first).
SELECT patient_name,
    age,
    gender,
    diagnosis,
    billing_amount
FROM patients
WHERE diagnosis LIKE '%Cancer%'
ORDER BY age ASC;
-- Interpretation: By utilizing the LIKE operator, we effectively retrieve all variations of cancer diagnoses regardless of where the word appears. Sorting by youngest first highlights any pediatric or young-adult oncology trends for the research team.
-- Scenario 5: Recent Admissions Dashboard (8 points)
-- The front-desk supervisor wants a quick dashboard of the most recent admissions from Q3 2025 (July 1 – September 30). Show all patients admitted in this period whose status is 'Discharged' OR 'Stable'.
-- Display patient_name, admission_date, department, room_type, and status. Sort by admission_date (newest first), then LIMIT to 15 records.
SELECT patient_name,
    admission_date,
    department,
    room_type,
    status
FROM patients
WHERE admission_date BETWEEN '2025-07-01' AND '2025-09-30'
    AND (
        status = 'Discharged'
        OR status = 'Stable'
    )
ORDER BY admission_date DESC
LIMIT 15;
-- Interpretation: This pulls a clean, 15-record snapshot of recently stabilized or discharged patients from Q3. It gives the front-desk supervisor an immediate, sorted view of recent turnover and current stable room occupancy.