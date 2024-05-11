/*
Connect tables not having PK/FL relationship but having same number of columns, datatype and order of the columns is same
UNION - Perform SORT DISTINCT Operation before removing duplicates, It is slower due to duplicate removal operation
UNION ALL - It does not remove duplicates, Is is faster

UNION VS JOIN
UNION 
1. Combine rows from two or more tables
2. It combines columns do not have PK/FP relationship
3. Column names, Datatypes, number of columns should be same , and order of columns in query should be appropriate 

JOIN
1. Combine columns from two or more tables
2. It combine columns having PK/FK relationship
*/

CREATE TABLE Emp1(
ID INT IDENTITY(1,1) NOT NULL,
Name VARCHAR(50),
City VARCHAR(50),
Salary NUMERIC
)
DELETE FROM Emp1
INSERT INTO Emp1 VALUES ('Nikhil Jagnade', 'Nagpur', 50000),
						('Harshal Jagnade', 'Pune', 20000),
						('Praful Jagnade', 'Mumbai', 30000),
						('Kalpna Jagnade', 'Mumbai', 30000)

CREATE TABLE Emp2(
ID INT IDENTITY(1,1) NOT NULL,
Name VARCHAR(50),
City VARCHAR(50),
Salary NUMERIC
)
DELETE FROM Emp2
INSERT INTO Emp2 VALUES ('Ved Jagnade', 'Bhopal', 10000),
						('Shraddha Jagnade', 'Siaha', 90000),
						('Bhushan Wankhede', 'Aizwal', 60000),
						('Kalpna Jagnade', 'Mumbai', 30000)

CREATE TABLE Department(
ID INT IDENTITY(1,1) NOT NULL,
Name VARCHAR(50),
)
INSERT INTO Department VALUES ('IT'),
						('FINANCE'),
						('OPERATIONS')


--UNION - Perform DISTINCT SORT operation before removing duplicates
--the number of columns, datatype and order of column should be same
SELECT * FROM Emp1
UNION
SELECT * FROM Emp2

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT ID, Name FROM Emp1
UNION
SELECT ID, Name, City FROM Emp2

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT * FROM Emp1
UNION 
SELECT * FROM Department

--Successfull as column names, order of columns and dataype is same
SELECT ID, Name FROM Emp1
UNION
SELECT ID, Name FROM Department

--Order of columns changed
--Error: Conversion failed when converting the varchar value 'Nikhil Jagnade' to data type int.
SELECT Name, ID FROM Emp1
UNION
SELECT ID, Name FROM Department


--UNION ALL - COmbine all rows duplicate & Non duplicate
--the number of columns, datatype and order of column should be same
SELECT * FROM Emp1
UNION ALL
SELECT * FROM Emp2

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT ID, Name FROM Emp1
UNION ALL
SELECT ID, Name, City FROM Emp2

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT * FROM Emp1
UNION ALL
SELECT * FROM Department

--Successfull as column names, order of columns and dataype is same
SELECT ID, Name FROM Emp1
UNION ALL
SELECT ID, Name FROM Department

--Order of columns changed
--Error: Conversion failed when converting the varchar value 'Nikhil Jagnade' to data type int.
SELECT Name, ID FROM Emp1
UNION ALL
SELECT ID, Name FROM Department


--INTERSECT - Returns only common records between both the tables
--the number of columns, datatype and order of column should be same
SELECT * FROM Emp1
INTERSECT
SELECT * FROM Emp2 -- 1 records

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT ID, Name FROM Emp1
INTERSECT
SELECT ID, Name, City FROM Emp2

--Error: All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT * FROM Emp1
INTERSECT
SELECT * FROM Department

--Successfull as column names, order of columns and dataype is same
SELECT ID, Name FROM Emp1
INTERSECT
SELECT ID, Name FROM Department -- 0 records

--Order of columns changed
--Error: Conversion failed when converting the varchar value 'Nikhil Jagnade' to data type int.
SELECT Name, ID FROM Emp1
UNION
SELECT ID, Name FROM Department