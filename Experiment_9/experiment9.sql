-- =========================
-- DROP TABLES (cleanup)
-- =========================
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS user_logs;
DROP TABLE IF EXISTS update_logs;
DROP TABLE IF EXISTS delete_logs;

-- =========================
-- MAIN TABLE
-- =========================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- =========================
-- LOG TABLES
-- =========================
CREATE TABLE user_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT,
    action TEXT,
    log_time TIMESTAMP
);

CREATE TABLE update_logs (
    id SERIAL PRIMARY KEY,
    old_name TEXT,
    new_name TEXT,
    updated_at TIMESTAMP
);

CREATE TABLE delete_logs (
    id SERIAL PRIMARY KEY,
    deleted_user TEXT,
    deleted_at TIMESTAMP
);

-- =========================
-- BEFORE INSERT TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION before_insert_users()
RETURNS TRIGGER AS $$
BEGIN
    NEW.created_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION before_insert_users();

-- =========================
-- AFTER INSERT TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION after_insert_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_logs(user_id, action, log_time)
    VALUES (NEW.id, 'INSERT', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_insert_users
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION after_insert_users();

-- =========================
-- BEFORE UPDATE TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION before_update_users()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.name IS NULL THEN
        RAISE EXCEPTION 'Name cannot be NULL';
    END IF;

    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_update_users
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION before_update_users();

-- =========================
-- AFTER UPDATE TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION after_update_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO update_logs(old_name, new_name, updated_at)
    VALUES (OLD.name, NEW.name, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_users
AFTER UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION after_update_users();

-- =========================
-- BEFORE DELETE TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION before_delete_users()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.name = 'admin' THEN
        RAISE EXCEPTION 'Cannot delete admin user';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_delete_users
BEFORE DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION before_delete_users();

-- =========================
-- AFTER DELETE TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION after_delete_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO delete_logs(deleted_user, deleted_at)
    VALUES (OLD.name, NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_delete_users
AFTER DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION after_delete_users();

-- =========================
-- STATEMENT LEVEL TRIGGER
-- =========================
CREATE OR REPLACE FUNCTION statement_trigger_example()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'A statement executed on users table';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_statement_users
AFTER INSERT ON users
FOR EACH STATEMENT
EXECUTE FUNCTION statement_trigger_example();

-- =========================
-- INSERT SAMPLE DATA
-- =========================
INSERT INTO users(name) VALUES ('Ankush');
INSERT INTO users(name) VALUES ('Rahul');
INSERT INTO users(name) VALUES ('admin');

-- =========================
-- UPDATE SAMPLE DATA
-- =========================
UPDATE users SET name = 'Ankush Kumar' WHERE name = 'Ankush';

-- =========================
-- DELETE SAMPLE DATA
-- =========================
DELETE FROM users WHERE name = 'Rahul';

-- This will FAIL (trigger demo)
-- DELETE FROM users WHERE name = 'admin';

-- =========================
-- VIEW RESULTS
-- =========================
SELECT * FROM users;
SELECT * FROM user_logs;
SELECT * FROM update_logs;
SELECT * FROM delete_logs;