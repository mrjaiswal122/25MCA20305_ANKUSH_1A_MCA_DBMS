-- ============================================
-- PostgreSQL Transaction Experiment
-- ============================================

-- =========================
-- DROP TABLE (CLEANUP)
-- =========================
DROP TABLE IF EXISTS accounts;

-- =========================
-- CREATE TABLE
-- =========================
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT,
    balance INT
);

-- =========================
-- INSERT INITIAL DATA
-- =========================
INSERT INTO accounts(name, balance) VALUES ('Ankush', 1000);
INSERT INTO accounts(name, balance) VALUES ('Rahul', 2000);

-- View initial state
SELECT * FROM accounts;

-- ============================================
-- BASIC TRANSACTION (TRANSFER MONEY)
-- ============================================

BEGIN;  -- Start transaction

-- Deduct 500 from Ankush
UPDATE accounts 
SET balance = balance - 500 
WHERE name = 'Ankush';

-- Add 500 to Rahul
UPDATE accounts 
SET balance = balance + 500 
WHERE name = 'Rahul';

COMMIT; -- Save changes permanently

-- Check result after commit
SELECT * FROM accounts;

-- ============================================
-- TRANSACTION WITH ROLLBACK (ERROR HANDLING)
-- ============================================

BEGIN;  -- Start transaction

-- Deduct 300 from Ankush
UPDATE accounts 
SET balance = balance - 300 
WHERE name = 'Ankush';

-- Simulating an error condition
-- Instead of committing, we rollback
ROLLBACK;

-- Verify that no changes were applied
SELECT * FROM accounts;

-- ============================================
-- TRANSACTION WITH SAVEPOINT
-- ============================================

BEGIN;  -- Start transaction

-- Step 1: Deduct 200 from Ankush
UPDATE accounts 
SET balance = balance - 200 
WHERE name = 'Ankush';

-- Create a savepoint after first operation
SAVEPOINT sp1;

-- Step 2: Add 200 to Rahul
UPDATE accounts 
SET balance = balance + 200 
WHERE name = 'Rahul';

-- Suppose something goes wrong here
-- Rollback only to savepoint (undo second step)
ROLLBACK TO sp1;

-- Commit remaining valid changes
COMMIT;

-- ============================================
-- FINAL RESULT
-- ============================================

SELECT * FROM accounts;