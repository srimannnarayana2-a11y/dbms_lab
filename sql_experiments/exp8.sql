-- Experiment 8: Normalization 1NF through 4NF (MySQL)
DROP DATABASE IF EXISTS NormalizationLabDB;
CREATE DATABASE NormalizationLabDB;
USE NormalizationLabDB;

CREATE TABLE EnrollmentRaw (StudentID INT, StudentName VARCHAR(40), CourseList VARCHAR(100));
INSERT INTO EnrollmentRaw VALUES
(1,'Anu','C101,C102'),(2,'Bala','C101'),(3,'Chitra','C102');

CREATE TABLE Enrollment1NF (
    StudentID INT, StudentName VARCHAR(40), CourseID VARCHAR(8), CourseName VARCHAR(40),
    InstructorID VARCHAR(8), InstructorName VARCHAR(40), Grade CHAR(1),
    PRIMARY KEY(StudentID,CourseID)
);
INSERT INTO Enrollment1NF VALUES
(1,'Anu','C101','DBMS','I10','Rao','A'),
(1,'Anu','C102','Networks','I20','Sen','B'),
(2,'Bala','C101','DBMS','I10','Rao','B'),
(3,'Chitra','C102','Networks','I20','Sen','A');

CREATE TABLE Students2NF (StudentID INT PRIMARY KEY, StudentName VARCHAR(40) NOT NULL);
CREATE TABLE Courses2NF (
    CourseID VARCHAR(8) PRIMARY KEY, CourseName VARCHAR(40),
    InstructorID VARCHAR(8), InstructorName VARCHAR(40)
);
CREATE TABLE Registrations2NF (
    StudentID INT, CourseID VARCHAR(8), Grade CHAR(1),
    PRIMARY KEY(StudentID,CourseID),
    FOREIGN KEY(StudentID) REFERENCES Students2NF(StudentID),
    FOREIGN KEY(CourseID) REFERENCES Courses2NF(CourseID)
);
INSERT INTO Students2NF VALUES (1,'Anu'),(2,'Bala'),(3,'Chitra');
INSERT INTO Courses2NF VALUES
('C101','DBMS','I10','Rao'),('C102','Networks','I20','Sen');
INSERT INTO Registrations2NF VALUES
(1,'C101','A'),(1,'C102','B'),(2,'C101','B'),(3,'C102','A');

CREATE TABLE Instructors3NF (
    InstructorID VARCHAR(8) PRIMARY KEY, InstructorName VARCHAR(40) NOT NULL
);
CREATE TABLE Courses3NF (
    CourseID VARCHAR(8) PRIMARY KEY, CourseName VARCHAR(40) NOT NULL,
    InstructorID VARCHAR(8) NOT NULL,
    FOREIGN KEY(InstructorID) REFERENCES Instructors3NF(InstructorID)
);
INSERT INTO Instructors3NF VALUES ('I10','Rao'),('I20','Sen');
INSERT INTO Courses3NF VALUES ('C101','DBMS','I10'),('C102','Networks','I20');

SELECT r.StudentID,s.StudentName,c.CourseName,i.InstructorName,r.Grade
FROM Registrations2NF r JOIN Students2NF s ON s.StudentID=r.StudentID
JOIN Courses3NF c ON c.CourseID=r.CourseID
JOIN Instructors3NF i ON i.InstructorID=c.InstructorID
ORDER BY r.StudentID,c.CourseID;

CREATE TABLE StudentInterestRaw (
    StudentID INT, Hobby VARCHAR(30), Language VARCHAR(30),
    PRIMARY KEY(StudentID,Hobby,Language)
);
INSERT INTO StudentInterestRaw VALUES
(1,'Chess','English'),(1,'Chess','Tamil'),
(1,'Music','English'),(1,'Music','Tamil');
CREATE TABLE StudentHobby4NF (StudentID INT, Hobby VARCHAR(30), PRIMARY KEY(StudentID,Hobby));
CREATE TABLE StudentLanguage4NF (StudentID INT, Language VARCHAR(30), PRIMARY KEY(StudentID,Language));
INSERT INTO StudentHobby4NF VALUES (1,'Chess'),(1,'Music');
INSERT INTO StudentLanguage4NF VALUES (1,'English'),(1,'Tamil');
SELECT h.StudentID,h.Hobby,l.Language FROM StudentHobby4NF h
JOIN StudentLanguage4NF l ON h.StudentID=l.StudentID
ORDER BY h.Hobby,l.Language;
