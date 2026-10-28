-- Experiment 2: Insertion, Deletion, Modification and Conditional Viewing (MySQL)
DROP DATABASE IF EXISTS PayrollLabDB;
CREATE DATABASE PayrollLabDB;
USE PayrollLabDB;

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50) NOT NULL,
    Department VARCHAR(25) NOT NULL,
    Designation VARCHAR(30) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    City VARCHAR(30),
    Join_Date DATE NOT NULL
);

INSERT INTO Employee VALUES
(201,'Asha','HR','Executive',38000,'Chennai','2023-06-12'),
(202,'Bharat','IT','Developer',52000,'Hyderabad','2022-08-01'),
(203,'Charan','Sales','Associate',32000,'Vijayawada','2024-01-15'),
(204,'Deepa','IT','Analyst',48000,'Bengaluru','2023-03-20'),
(205,'Eshan','Finance','Accountant',45000,'Chennai','2021-11-05'),
(206,'Farah','HR','Recruiter',41000,'Hyderabad','2024-02-10'),
(207,'Gopal','Sales','Executive',35000,'Nellore','2022-07-18'),
(208,'Hema','IT','Developer',56000,'Tirupati','2021-09-30');

INSERT INTO Employee VALUES
(209,'Ishita','Marketing','Coordinator',39000,'Guntur','2025-01-06');
UPDATE Employee SET Salary=55000 WHERE Emp_ID=202;
UPDATE Employee SET Salary=ROUND(Salary*1.10,2) WHERE Department='Sales';
UPDATE Employee SET Department='Operations' WHERE Emp_ID=206;

ALTER TABLE Employee ADD COLUMN Email VARCHAR(80) NULL;
UPDATE Employee SET Email='asha@company.test' WHERE Emp_ID=201;
UPDATE Employee SET Email='bharat@company.test' WHERE Emp_ID=202;
ALTER TABLE Employee MODIFY COLUMN Designation VARCHAR(50) NOT NULL;

SELECT Emp_ID, Emp_Name, Department, Salary FROM Employee
WHERE Salary>=45000 ORDER BY Salary DESC, Emp_ID;
DELETE FROM Employee WHERE Emp_ID=209;
DELETE FROM Employee WHERE Department='Operations' AND Emp_ID=206;
SELECT Emp_ID, Emp_Name, Department, Salary, Email FROM Employee ORDER BY Emp_ID;
