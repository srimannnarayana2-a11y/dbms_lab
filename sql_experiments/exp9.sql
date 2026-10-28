-- Experiment 9: Relationships, JOINs and Subqueries (MySQL)
DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (Dept_ID INT PRIMARY KEY, Dept_Name VARCHAR(40) NOT NULL UNIQUE);
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY, Emp_Name VARCHAR(40) NOT NULL, Dept_ID INT NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(Dept_ID) REFERENCES Departments(Dept_ID)
);
CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY, Project_Name VARCHAR(60) NOT NULL,
    Dept_ID INT NOT NULL, Budget DECIMAL(12,2) NOT NULL,
    FOREIGN KEY(Dept_ID) REFERENCES Departments(Dept_ID)
);
CREATE TABLE Assignments (
    Emp_ID INT NOT NULL, Project_ID INT NOT NULL, Hours INT NOT NULL,
    PRIMARY KEY(Emp_ID,Project_ID),
    FOREIGN KEY(Emp_ID) REFERENCES Employees(Emp_ID),
    FOREIGN KEY(Project_ID) REFERENCES Projects(Project_ID)
);

INSERT INTO Departments VALUES
(10,'Development'),(20,'Testing'),(30,'HR'),(40,'Research');
INSERT INTO Employees VALUES
(101,'Arun',10,60000),(102,'Priya',10,75000),(103,'Ravi',20,50000),
(104,'Sneha',20,55000),(105,'Kiran',30,45000),(106,'Divya',40,90000),(107,'Rahul',10,65000);
INSERT INTO Projects VALUES
(201,'Web Portal',10,300000),(202,'Mobile App',10,450000),(203,'QA Automation',20,200000),
(204,'AI Prototype',40,600000),(205,'Recruitment Portal',30,120000);
INSERT INTO Assignments VALUES
(101,201,30),(102,201,25),(102,202,35),(103,203,40),(104,203,20),(106,204,45),(107,202,30);

SELECT e.Emp_Name,d.Dept_Name FROM Employees e
JOIN Departments d ON e.Dept_ID=d.Dept_ID ORDER BY e.Emp_ID;
SELECT e.Emp_Name,p.Project_Name,a.Hours FROM Assignments a
JOIN Employees e ON a.Emp_ID=e.Emp_ID JOIN Projects p ON a.Project_ID=p.Project_ID
ORDER BY a.Emp_ID,a.Project_ID;
SELECT e.Emp_Name,p.Project_Name FROM Employees e
LEFT JOIN Assignments a ON e.Emp_ID=a.Emp_ID
LEFT JOIN Projects p ON a.Project_ID=p.Project_ID ORDER BY e.Emp_ID;
SELECT p.Project_Name,e.Emp_Name FROM Assignments a
RIGHT JOIN Projects p ON a.Project_ID=p.Project_ID
LEFT JOIN Employees e ON a.Emp_ID=e.Emp_ID ORDER BY p.Project_ID,e.Emp_ID;
SELECT d.Dept_Name,p.Project_Name FROM Departments d CROSS JOIN Projects p
WHERE d.Dept_ID=30 ORDER BY p.Project_ID;

SELECT Emp_Name,Salary FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
SELECT Emp_Name FROM Employees WHERE Dept_ID IN
(SELECT Dept_ID FROM Departments WHERE Dept_Name='Development');
SELECT Emp_Name FROM Employees e WHERE EXISTS
(SELECT 1 FROM Assignments a WHERE a.Emp_ID=e.Emp_ID);
SELECT Emp_Name FROM Employees e WHERE NOT EXISTS
(SELECT 1 FROM Assignments a WHERE a.Emp_ID=e.Emp_ID);
