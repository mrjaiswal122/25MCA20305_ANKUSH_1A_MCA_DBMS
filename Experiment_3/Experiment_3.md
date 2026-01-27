# Worksheet No. 3

**Student Name:** Ankush Kumar  
**UID:** 25MCA20305  
**Branch:** MCA  
**Section/Group:** 1A  
**Semester:** 2nd  
**Date of Performance:** 27th Jan, 2026  

**Subject Name:** Technical Training  
**Subject Code:** 25CAP-652  

---

## Aim / Overview of the Practical

To implement conditional decision-making logic in PostgreSQL using **IF–ELSE constructs**
and **CASE expressions** for classification, validation, and rule-based data processing.

## Objective

- To understand conditional execution in SQL  
- To implement decision-making logic using CASE expressions  
- To simulate real-world rule validation scenarios  
- To classify data based on multiple conditions  
- To strengthen SQL logic skills required in interviews and backend systems  

## Input / Apparatus Used

- PostgreSQL  
- pgAdmin  

---

## Procedure / Algorithm / Code

### Step 1: Classifying Data Using CASE Expression

```sql
CREATE TABLE schema_audit (
    schema_name VARCHAR(50),
    violation_count INT
);

INSERT INTO schema_audit VALUES
('auth_schema', 0),
('user_schema', 2),
('payment_schema', 5),
('admin_schema', 9),
('log_schema', 14);

SELECT
    schema_name,
    violation_count,
    CASE
        WHEN violation_count = 0 THEN 'No Violation'
        WHEN violation_count BETWEEN 1 AND 3 THEN 'Minor Violation'
        WHEN violation_count BETWEEN 4 AND 7 THEN 'Moderate Violation'
        ELSE 'Critical Violation'
    END AS violation_level
FROM schema_audit;
```

---

### Step 2: Applying CASE Logic in Data Updates

```sql
ALTER TABLE schema_audit
ADD COLUMN approval_status VARCHAR(30);

UPDATE schema_audit
SET approval_status =
    CASE
        WHEN violation_count = 0 THEN 'Approved'
        WHEN violation_count BETWEEN 1 AND 5 THEN 'Needs Review'
        ELSE 'Rejected'
    END;

SELECT * FROM schema_audit;
```

---

### Step 3: Implementing IF–ELSE Logic Using PL/pgSQL

```sql
DO $$
DECLARE
    v_count INT := 6;
BEGIN
    IF v_count = 0 THEN
        RAISE NOTICE 'Schema Status: Approved';
    ELSIF v_count <= 5 THEN
        RAISE NOTICE 'Schema Status: Needs Review';
    ELSE
        RAISE NOTICE 'Schema Status: Rejected';
    END IF;
END $$;
```

---

### Step 4: Real-World Classification Scenario (Grading System)

```sql
CREATE TABLE student_results (
    student_id INT,
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO student_results VALUES
(1, 'Amit', 92),
(2, 'Riya', 78),
(3, 'Rahul', 64),
(4, 'Sneha', 48),
(5, 'Karan', 85);

SELECT
    student_name,
    marks,
    CASE
        WHEN marks >= 90 THEN 'A'
        WHEN marks >= 75 THEN 'B'
        WHEN marks >= 50 THEN 'C'
        ELSE 'D'
    END AS grade
FROM student_results;
```

---

### Step 5: Using CASE for Custom Sorting

```sql
SELECT
    schema_name,
    violation_count,
    approval_status
FROM schema_audit
ORDER BY
    CASE
        WHEN violation_count = 0 THEN 1
        WHEN violation_count BETWEEN 1 AND 3 THEN 2
        WHEN violation_count BETWEEN 4 AND 7 THEN 3
        ELSE 4
    END,
    violation_count DESC;
```

---

## Output

- Schema-wise violation classification  
- Approval status based on violation severity  
- Conditional messages using PL/pgSQL  
- Student grading based on marks  
- Priority-based sorted reports  

---

## Learning Outcomes

1. I learned how to use **searched CASE expressions** to classify real-world data such as schema violations.
2. I understood how **CASE logic inside UPDATE statements** helps automate approval decisions at the database level.
3. I learned to implement **procedural control flow using PL/pgSQL (IF–ELSIF–ELSE)**.
4. I practiced **rule-based data categorization**, such as grading students based on marks.
5. I learned how to apply **custom sorting using CASE in ORDER BY** clauses.
6. I gained confidence in combining **DDL, DML, and procedural SQL** for real-world scenarios.

---
