-- Checking if database exists
USE master;

IF EXISTS (
   SELECT 1
   FROM sys.databases
   WHERE name = N'CAMUDB'
)

BEGIN
   DROP DATABASE CAMUDB;
END
GO

CREATE DATABASE CAMUDB;
GO
USE CAMUDB;
GO


-- Create the Student table
CREATE TABLE Student (
   studentID INT PRIMARY KEY,
   fname VARCHAR(20) NOT NULL,
   lname VARCHAR(20) NOT NULL,
   year INT NOT NULL,
   major VARCHAR(5) NOT NULL,
   date_of_birth DATE NOT NULL,
   email VARCHAR(50) NOT NULL,
   CONSTRAINT U_student_email UNIQUE(email)
);
GO

-- Create the StudentPhone table
CREATE TABLE StudentPhone (
   studentID INT NOT NULL,
   phone_number VARCHAR(20) NOT NULL,
   FOREIGN KEY (studentID) REFERENCES Student(studentID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT U_student_phone_number UNIQUE(phone_number)
);
GO

-- Create the StudentAddress table
CREATE TABLE StudentAddress (
   studentID INT NOT NULL,
   postal_address VARCHAR(100) NOT NULL,
   street_number VARCHAR(20) NOT NULL,
   city VARCHAR(50) NOT NULL,
   town VARCHAR(50) NOT NULL,
   FOREIGN KEY (studentID) REFERENCES Student(studentID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the StudentLogin table
CREATE TABLE StudentLogin (
   student_email VARCHAR(50) NOT NULL,
   password VARCHAR(100) NOT NULL,
   CONSTRAINT U_studentlog_email UNIQUE(student_email)
);
GO

-- Create the Course table
CREATE TABLE Course (
   courseID INT PRIMARY KEY,
   course_name VARCHAR(50) NOT NULL,
   dept VARCHAR(50) NOT NULL,
   course_credit TINYINT NOT NULL
);
GO

-- Create the Staff table
CREATE TABLE Staff (
   staffID INT PRIMARY KEY,
   fname VARCHAR(20) NOT NULL,
   lname VARCHAR(20) NOT NULL,
   date_of_birth DATE NOT NULL,
   dept VARCHAR(50) NOT NULL,
   salary SMALLMONEY NOT NULL,
   email VARCHAR(100) NOT NULL
   CONSTRAINT U_staff_email UNIQUE(email)
);
GO

-- Create the StaffPhone table
CREATE TABLE StaffPhone (
   staffID INT,
   phone_number VARCHAR(20) NOT NULL,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT U_staff_phone_number UNIQUE(phone_number)
);
GO

-- Create the StaffAddress table
CREATE TABLE StaffAddress (
   staffID INT,
   postal_address VARCHAR(100) NOT NULL,
   street_number VARCHAR(20) NOT NULL,
   city VARCHAR(50) NOT NULL,
   town VARCHAR(50) NOT NULL,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the StaffLogin table
CREATE TABLE StaffLogin (
   staff_email VARCHAR(100) NOT NULL,
   password VARCHAR(100) NOT NULL
   CONSTRAINT U_stafflog_email UNIQUE(staff_email)
);
GO

-- Create the Lecturer table
CREATE TABLE Lecturer (
   staffID INT,
   date_started DATE NOT NULL,
   position VARCHAR(50) NOT NULL,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the FacultyIntern table
CREATE TABLE FacultyIntern (
   staffID INT PRIMARY KEY,
   date_started DATE NOT NULL,
   is_alumni BIT NOT NULL,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the Department table
CREATE TABLE Department (
   deptID INT PRIMARY KEY,
   dept_name VARCHAR(50) NOT NULL,
   dept_head INT NOT NULL,
   FOREIGN KEY (dept_head) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the Enrollment table
CREATE TABLE Enrollment (
   studentID INT NOT NULL,
   staffID INT NOT NULL,
   courseID INT NOT NULL,
   FOREIGN KEY (studentID) REFERENCES Student(studentID) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (courseID) REFERENCES Course(courseID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the StudentCourse table
CREATE TABLE StudentCourse (
   studentID INT NOT NULL,
   courseID INT NOT NULL,
   FOREIGN KEY (studentID) REFERENCES Student(studentID) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (courseID) REFERENCES Course(courseID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the StaffCourse table
CREATE TABLE StaffCourse (
   staffID INT NOT NULL,
   courseID INT NOT NULL,
   FOREIGN KEY (staffID) REFERENCES Staff(staffID) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (courseID) REFERENCES Course(courseID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Create the Classroom table
CREATE TABLE Classroom (
   classID INT PRIMARY KEY,
   className VARCHAR(50) NOT NULL
);
GO

-- Create the CourseClassroom table
CREATE TABLE CourseClassroom (
   courseID INT NOT NULL,
   classID INT NOT NULL,
   FOREIGN KEY (courseID) REFERENCES Course(courseID) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (classID) REFERENCES Classroom(classID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO


-- DATA POPULATION

-- Insert data into Student table
INSERT INTO Student (studentID, fname, lname, year, major, date_of_birth, email)
VALUES 
(10012023, 'John', 'Doe', 2023, 'CS', '2000-01-01', 'john.doe@ashesi.edu.gh'),
(10022024, 'Jane', 'Ball', 2024, 'MIS', '2001-02-02', 'jane.ball@ashesi.edu.gh'),
(10032026, 'Mark', 'Smith', 2026, 'BA', '1999-03-03', 'mark.smith@ashesi.edu.gh'),
(10042025, 'Mary', 'Johnson', 2025, 'CE', '2002-04-04', 'mary.johnson@ashesi.edu.gh'),
(10052024, 'David', 'Lee', 2024, 'EE', '2000-05-05', 'david.lee@ashesi.edu.gh');

-- Insert data into StudentPhone table
INSERT INTO StudentPhone (studentID, phone_number)
VALUES 
(10012023, '1234567890'),
(10012023, '6985745230'),
(10022024, '2345678901'),
(10032026, '3456789012'),
(10042025, '4567890123'),
(10052024, '3789541120'),
(10042025, '9745896512'),
(10052024, '6657423654'),
(10052024, '2031017896'),
(10052024, '5126478965');

-- Insert data into StudentAddress table
INSERT INTO StudentAddress (studentID, postal_address, street_number, city, town)
VALUES 
(10012023, 'P.O. Box 1234', '1st Street', 'Accra', 'East Legon'),
(10022024, 'P.O. Box 2345', '2nd Street', 'Kumasi', 'Ayigya'),
(10032026, 'P.O. Box 3456', '3rd Street', 'Takorai', 'TaadiBon'),
(10042025, 'P.O. Box 4567', '4th Street', 'Accra', 'Labadi'),
(10052024, 'P.O. Box 5678', '5th Street', 'Tamale', 'Lufta');

-- Insert data into StudentLogin table
INSERT INTO StudentLogin (student_email, password)
VALUES 
('john.doe@ashesi.edu.gh', 'password1'),
('jane.ball@ashesi.edu.gh', 'password2'),
('mark.smith@ashesi.edu.gh', 'password3'),
('mary.johnson@ashesi.edu.gh', 'password4'),
('david.lee@ashesi.edu.gh', 'password5');

-- Insert data into Course table
INSERT INTO Course (courseID, course_name, dept, course_credit)
VALUES 
(101, 'Intro to Computing', 'CSIS', 3),
(102, 'Financial Accounting', 'Business', 3),
(103, 'Accounting Principles', 'Business', 3),
(104, 'Calculus', 'Math', 4),
(105, 'Introduction to Engineering', 'Engineering', 4),
(106, 'Signals and Systems', 'Engineering', 4);

-- Insert data into Staff table
INSERT INTO Staff (staffID, fname, lname, date_of_birth, dept, salary, email)
VALUES 
   (1, 'David', 'Sampah', '1990-05-12', 'CSIS', 5000, 'david.sampah@ashesi.edu.gh'),
   (2, 'Ian', 'Kotey', '1992-02-29', 'CSIS', 6000, 'ian.kotey@ashesi.edu.gh'),
   (3, 'Joe', 'Mens', '1988-11-15', 'Math', 7000, 'joe.mens@ashesi.edu.gh'),
   (4, 'Betty', 'Blankson', '1995-08-18', 'Business', 8000, 'betty.blankson@ashesi.edu.gh'),
   (5, 'Salomey', 'Satah', '1993-07-09', 'Engineering', 12500, 'yvonne.kara@ashesi.edu.gh'),
   (6, 'Itachi', 'Uchiha', '1990-06-01', 'Engineering', 5500, 'itachi.uchiha@ashesi.edu.gh'),
   (7, 'Light', 'Yagami', '2001-03-02', 'Math', 4500, 'light.yagami@ashesi.edu.gh'),
   (8, 'Naruto', 'Uzumaki', '2003-05-03', 'Engineering', 8500, 'naturo.uzumaki@ashesi.edu.gh'),
   (9, 'Eren', 'Yeager', '1990-02-04', 'Business', 9500, 'eren.yeager@ashesi.edu.gh'),
   (10, 'Isagi', 'Yoichi', '1992-01-05', 'CSIS', 6500, 'isagi.yoichi@ashesi.edu.gh');


INSERT INTO StaffPhone (staffID, phone_number)
VALUES
   (1, '0241234567'),
   (2, '0207654321'),
   (3, '0271111111'),
   (4, '0242222222'),
   (5, '33322211778'),
   (6, '1236598745'),
   (7, '9898456541'),
   (8, '89247632459'),
   (9, '33665544189'),
   (10, '0024587965'),
   (1, '5632478552'),
   (2, '6547896541'),
   (3, '5632145789');

-- Populate the StaffAddress table
INSERT INTO StaffAddress (staffID, postal_address, street_number, city, town) VALUES
(1, 'P.O. Box CT 1', '1 University Avenue', 'Berekuso', 'Ashesi University'),
(2, 'P.O. Box CT 2', '2 University Avenue', 'Berekuso', 'Carabao'),
(3, 'P.O. Box CT 3', '3 University Avenue', 'Accra', 'Lomnava'),
(4, 'P.O. Box CT 4', '4 School Avenue', 'Berekuso', 'Sowutuom'),
(5, 'P.O. Box CT 5', '5 University Avenue', 'Lapaz', 'Lapaz'),
(6, 'P.O. Box CT 6', '6 University Avenue', 'Accra', 'Cantonments'),
(7, 'P.O. Box CT 7', '7 University Avenue', 'Berekuso', 'Nima'),
(8, 'P.O. Box CT 8', '8 University Avenue', 'Accra', 'Newtown'),
(9, 'P.O. Box CT 9', '9 University Avenue', 'Berekuso', 'Circle'),
(10, 'P.O. Box CT 10', '10 University Avenue', 'Berekuso', 'La');

-- Populate the StaffLogin table
INSERT INTO StaffLogin (staff_email, password) VALUES
('david.sampah@ashesi.edu.gh', 'password123'),
('ian.kotey@ashesi.edu.gh', 'qwerty123'),
('joe.mens@ashesi.edu.gh', 'password456'),
('betty.blankson@ashesi.edu.gh', 'qwerty456'),
('yvonne.kara@ashesi.edu.gh', 'polsfgn789'),
('itachi.uchiha@ashesi.edu.gh', 'bgfdrt789'),
('light.yagami@ashesi.edu.gh', 'rtyuio789'),
('naruto.uzumaki@ashesi.edu.gh', 'ghjkl789'),
('eren.yeager@ashesi.edu.gh', 'asdfg789'),
('isagi.yoichi@ashesi.edu.gh', 'zxcvb789');


-- Insert data into Lecturer table
INSERT INTO Lecturer (staffID, date_started, position)
VALUES (1, '2020-01-01', 'Assistant Professor'),
       (3, '2018-08-01', 'Associate Professor'),
       (2, '2010-09-01', 'Professor'),
       (5, '2010-09-01', 'Professor'),
       (4, '2010-09-01', 'Professor');

-- Insert data into FacultyIntern table
INSERT INTO FacultyIntern (staffID, date_started, is_alumni)
VALUES (10, '2019-01-01', 1),
       (7, '2017-06-01', 0),
      (9, '2020-09-01', 1),
      (6, '2020-09-01', 0),
      (8, '2020-09-01', 1);

-- Populate Department table
INSERT INTO Department (deptID, dept_name, dept_head) VALUES
(1, 'Mathematics', 3),
(2, 'CSIS', 1),
(3, 'Engineering', 6),
(4, 'Business', 5);

INSERT INTO Enrollment (studentID, staffID, courseID)
VALUES
   (10012023, 5, 101),
   (10052024, 7, 102),
   (10042025, 6, 103),
   (10032026, 8, 104),
   (10022024, 5, 105),
   (10012023, 7, 106),
   (10052024, 6, 101),
   (10032026, 8, 102),
   (10042025, 5, 103),
   (10022024, 7, 104);

INSERT INTO StudentCourse (studentID, courseID)
VALUES
(10012023, 101),
(10052024, 102),
(10042025, 104),
(10032026, 102),
(10022024, 103),
(10012023, 101),
(10032026, 106),
(10042025, 103),
(10022024, 105);

INSERT INTO StaffCourse (staffID, courseID)
VALUES
(1, 103),
(2, 102),
(3, 103),
(4, 104),
(5, 103),
(6, 104),
(7, 105),
(8, 101),
(9, 105),
(10, 106);

-- insert data into Classroom table
INSERT INTO Classroom (classID, className) VALUES
    (1, 'Room 101'),
    (2, 'Room 102'),
    (3, 'Room 103'),
    (4, 'Room 104'),
    (5, 'Room 105');

-- insert data into CourseClassroom table
INSERT INTO CourseClassroom (courseID, classID) VALUES
    (101, 1),
    (101, 2),
    (102, 3),
    (103, 4),
    (104, 5);


GO
-- VIEWS
-- STUDENT PROFILE VIEW
CREATE VIEW dbo.StudentProfileView
WITH SCHEMABINDING
AS
SELECT s.studentID, s.fname, s.lname, s.year, s.major, s.date_of_birth, s.email, sp.phone_number, sa.street_number, sa.city, sa.town
FROM dbo.Student AS s JOIN dbo.StudentPhone AS sp
ON s.studentID = sp.studentID
JOIN dbo.StudentAddress AS sa
ON s.studentID = sa.studentID
WITH CHECK OPTION;
GO

-- Faculty Profile View
CREATE VIEW dbo.FacultyViewOfStudentProfile
WITH SCHEMABINDING
AS
SELECT s.studentID, s.fname, s.lname, s.year, s.major, s.email
FROM dbo.Student AS s
WITH CHECK OPTION;
GO

--Student Enrollment View
CREATE VIEW dbo.StudentEnrollmentView
WITH SCHEMABINDING
AS
SELECT e.studentID, e.staffID, e.courseID, c.course_name, s.fname, s.lname, st.fname AS 'Staff_firstname', st.lname AS 'Staff_lastname'
FROM dbo.Enrollment AS e 
LEFT OUTER JOIN dbo.Course AS c 
ON e.courseID = c.courseID
JOIN dbo.Student AS s
ON e.studentID = s.studentID
JOIN dbo.Staff as st
ON e.staffID = st.staffID
WITH CHECK OPTION;
GO

CREATE VIEW dbo.FacultyProfileView
WITH SCHEMABINDING
AS
SELECT s.staffID, s.fname, s.lname, s.dept, s.date_of_birth, s.email, sp.phone_number, sa.street_number, sa.city, sa.town
FROM dbo.Staff AS s JOIN dbo.StaffPhone AS sp
ON s.staffID = sp.staffID
JOIN dbo.StaffAddress AS sa
ON s.staffID = sa.staffID
WITH CHECK OPTION;
GO


-- QUERIES --

-- FUNCTIONS
-- create function to view student details. Can be done by both staff and students, but view is different
IF OBJECT_ID(N'viewStudentDetails_Student', N'IF') IS NOT NULL
DROP FUNCTION viewStudentDetails_Student;
GO

CREATE FUNCTION viewStudentDetails_Student(@ID INT)
RETURNS TABLE
AS RETURN
	SELECT studentID, fname, lname, year, major, email, phone_number, street_number, city, town
	FROM StudentProfileView
	WHERE StudentProfileView.studentID = @ID
GO

IF OBJECT_ID(N'viewStudentDetails_Faculty', N'IF') IS NOT NULL
DROP FUNCTION viewStudentDetails_Faculty;
GO

CREATE FUNCTION viewStudentDetails_Faculty(@ID INT)
RETURNS TABLE
AS RETURN
	SELECT studentID, fname, lname, year, major, email
	FROM FacultyViewOfStudentProfile
	WHERE FacultyViewOfStudentProfile.studentID = @ID
GO

IF OBJECT_ID(N'viewStudentEnrollmentDetails', N'IF') IS NOT NULL
DROP FUNCTION viewStudentEnrollmentDetails;
GO

-- function to view student enrollment details
CREATE FUNCTION viewStudentEnrollmentDetails(@studentID INT)
RETURNS TABLE
AS
RETURN (
   SELECT * FROM StudentEnrollmentView
   WHERE StudentEnrollmentView.studentID = @studentID
);
GO

--Faculty
IF OBJECT_ID(N'viewFacultyDetails', N'IF') IS NOT NULL
DROP FUNCTION viewFacultyDetails;
GO

CREATE FUNCTION viewFacultyDetails(@ID INT)
RETURNS TABLE
AS RETURN
	SELECT staffID, fname, lname, dept, date_of_birth, email, phone_number, street_number, city, town
	FROM FacultyProfileView
	WHERE FacultyProfileView.staffID = @ID
GO


-- PROCEDURES

--create inline function to un-enroll and enroll students from a course. Querying the tables directly because
-- the operation is a privileged operation. Only the academic registry can do it
-- un-enrolling
IF OBJECT_ID('unenroll', 'P') IS NOT NULL
DROP PROC unenroll;
GO

CREATE PROCEDURE unenroll
	@studentID AS INT,
	@courseID AS INT,
	@status AS BIT = 0 OUTPUT
AS
BEGIN 
	SET NOCOUNT ON;
	IF EXISTS (
		SELECT studentID 
		FROM Enrollment 
		WHERE Enrollment.studentID = @studentID
	)
	BEGIN 
		DELETE FROM Enrollment WHERE Enrollment.studentID = @studentID;
		DELETE FROM StudentCourse WHERE StudentCourse.studentID = @studentID AND StudentCourse.courseID = @courseID;
		SET @status = 1;
	END
END
GO

-- enrolling
IF OBJECT_ID('enroll', 'P') IS NOT NULL
DROP PROC enroll;
GO

CREATE PROCEDURE enroll
	@studentID AS INT,
	@courseID AS INT,
	@staffID AS INT,
	@status AS BIT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
   IF EXISTS (
      SELECT Student.studentID, Course.courseID, Staff.staffID 
	  FROM Student, Course, Staff 
	  WHERE Student.studentID = @studentID AND Course.courseID = @courseID AND Staff.staffID = @staffID
	  )
   BEGIN 
	INSERT INTO Enrollment VALUES(@studentID, @staffID, @courseID)
   END
END
GO


-- stored procedure to update student first name
IF OBJECT_ID('updateStudentFirstName', 'P') IS NOT NULL
DROP PROC updateStudentFirstName;
GO

CREATE PROCEDURE updateStudentFirstName
	@studentID AS INT,
	@fname AS VARCHAR(50),
	@status AS BIT = 0 OUTPUT
AS
BEGIN
   UPDATE Student
   SET fname = @fname
   WHERE Student.studentID = @studentID;
   SET @status = 1
END
GO

-- stored procedure to update student last name
IF OBJECT_ID('updateStudentLastName', 'P') IS NOT NULL
DROP PROC updateStudentLastName;
GO

CREATE PROCEDURE updateStudentLastName
	@studentID AS INT,
	@lname AS VARCHAR(50),
	@status AS BIT = 0 OUTPUT
AS
BEGIN
   UPDATE Student
   SET lname = @lname
   WHERE Student.studentID = @studentID
END
GO

-- stored procedure to update student phone number
IF OBJECT_ID('updateStudentPhoneNumber', 'P') IS NOT NULL
DROP PROC updateStudentPhoneNumber;
GO

CREATE PROCEDURE updateStudentPhoneNumber
	@studentID AS INT,
	@phoneNumber AS VARCHAR(20),
	@status AS BIT = 0 OUTPUT
AS
BEGIN
   UPDATE StudentPhone
   SET phone_number = @phoneNumber
   WHERE StudentPhone.studentID = @studentID
END
GO

-- procedure to update student address
IF OBJECT_ID('updateStudentAddress', 'P') IS NOT NULL
DROP PROC updateStudentAddress;
GO

CREATE PROCEDURE updateStudentAddress
	@studentID AS INT='',
	@postalAddress AS VARCHAR(100)='',
	@streetNumber AS VARCHAR(20)='',
	@city AS VARCHAR(50)='',
	@town AS VARCHAR(50)='',
	@status AS BIT = 0 OUTPUT
AS
BEGIN  -- using IF statements because T-SQL case statements don't support fall-through; also, not using views because it has limitations in update
   IF @postalAddress <> ''
      UPDATE StudentAddress
      SET postal_address = @postalAddress
      WHERE StudentAddress.studentID = @studentID
   IF @streetNumber <> ''
      UPDATE StudentAddress
      SET street_number = @streetNumber
      WHERE StudentAddress.studentID = @studentID
   IF @city <> ''
      UPDATE StudentAddress
      SET city = @city
      WHERE StudentAddress.studentID = @studentID
   IF @town <> ''
      UPDATE StudentAddress
      SET town = @town
      WHERE StudentAddress.studentID = @studentID
END
GO

IF OBJECT_ID('viewStudentDetails', 'P') IS NOT NULL
DROP PROC viewStudentDetails;
GO

CREATE PROCEDURE viewStudentDetails 
	@ID AS INT,
	@isStudent AS BIT = 0
AS
BEGIN
	SET NOCOUNT ON;
	IF @isStudent = 0
		SELECT * FROM viewStudentDetails_Faculty(@ID)
	ELSE 
		SELECT * FROM viewStudentDetails_Student(@ID)
END

IF OBJECT_ID('viewLecturerHistory', 'P') IS NOT NULL
DROP PROC viewLecturerHistory;
GO

CREATE PROCEDURE viewLecturerHistory 
	@startDate AS DATETIME = '19850101'
AS
BEGIN
	SET NOCOUNT ON;
	SELECT CONCAT(s.fname, ' ', s.lname) AS Fullname, s.dept AS Department, l.date_started AS 'Date started'
	FROM Staff s
	INNER JOIN Lecturer l ON s.staffID = l.staffID
	WHERE l.date_started >= @startDate;
END
GO

IF OBJECT_ID('FacultyDetails', 'P') IS NOT NULL
DROP PROC FacultyDetails;
GO

CREATE PROCEDURE FacultyDetails 
	@ID AS INT,
	@isFaculty AS BIT = 0
AS
BEGIN
	SET NOCOUNT ON;
	IF @isFaculty = 1
		SELECT * FROM viewFacultyDetails(@ID)
	ELSE 
		THROW 50000, 'Only faculty are allowed to view this information', 0;
END