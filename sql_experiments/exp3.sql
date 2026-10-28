-- Experiment 3: DCL and TCL Commands (MySQL)
DROP DATABASE IF EXISTS BankDB;
CREATE DATABASE BankDB;
USE BankDB;

CREATE TABLE BankAccount (
    Account_ID INT PRIMARY KEY,
    Holder_Name VARCHAR(50) NOT NULL,
    Branch VARCHAR(30) NOT NULL,
    Balance DECIMAL(12,2) NOT NULL CHECK (Balance >= 0),
    Account_Type VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

INSERT INTO BankAccount VALUES
(201,'Anand','Chennai',50000,'Savings'),
(202,'Bhavya','Hyderabad',35000,'Savings'),
(203,'Charan','Vijayawada',20000,'Current'),
(204,'Deepa','Chennai',45000,'Savings'),
(205,'Eshan','Bengaluru',60000,'Current');

-- DCL (run these with an administrator account)
CREATE USER IF NOT EXISTS 'lab_teller3'@'localhost'
IDENTIFIED BY 'LabDemo_ChangeMe_2026!';
GRANT SELECT ON BankDB.BankAccount TO 'lab_teller3'@'localhost';
SHOW GRANTS FOR 'lab_teller3'@'localhost';
-- Test SELECT/UPDATE using a separate lab_teller3 connection, then revoke:
-- REVOKE SELECT ON BankDB.BankAccount FROM 'lab_teller3'@'localhost';

START TRANSACTION;
UPDATE BankAccount SET Balance=Balance+5000 WHERE Account_ID=201;
COMMIT;

START TRANSACTION;
UPDATE BankAccount SET Balance=Balance-3000 WHERE Account_ID=202;
ROLLBACK;

START TRANSACTION;
UPDATE BankAccount SET Balance=Balance+1000 WHERE Account_ID=203;
SAVEPOINT after_first_change;
UPDATE BankAccount SET Balance=Balance+2000 WHERE Account_ID=204;
ROLLBACK TO SAVEPOINT after_first_change;
COMMIT;

START TRANSACTION;
UPDATE BankAccount SET Balance=Balance-4000 WHERE Account_ID=201;
UPDATE BankAccount SET Balance=Balance+4000 WHERE Account_ID=202;
COMMIT;

SELECT Account_ID, Holder_Name, Balance FROM BankAccount ORDER BY Account_ID;
