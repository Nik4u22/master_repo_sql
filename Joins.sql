USE Practice_DB

DROP TABLE IF EXISTS JoinTB1
CREATE TABLE JoinTB1(
ID Varchar(10)
)
INSERT INTO JoinTB1 VALUES (1), (2), (2), (3), (4), (5), (5), (6), (8) 

DROP TABLE IF EXISTS JoinTB2
CREATE TABLE JoinTB2(
ID Varchar(10)
)
INSERT INTO JoinTB2 VALUES (1), (2), (2), (3), (3), (3), (4), (6), (7) 

DROP TABLE IF EXISTS JoinTB3
CREATE TABLE JoinTB3(
ID Varchar(10)
)
INSERT INTO JoinTB3 VALUES (1), (2), (2), (3), (3), (3), (4), (Null), (6), (Null) 

DROP TABLE IF EXISTS JoinTB4
CREATE TABLE JoinTB4(
ID Varchar(10)
)
INSERT INTO JoinTB4 VALUES (1), (1), (2), (3), (3), (4), (5), (7), (8), (Null) 

DROP TABLE IF EXISTS JoinTB5
CREATE TABLE JoinTB5(
ID Varchar(10)
)
INSERT INTO JoinTB5 VALUES (1), (1), (1), (1),(Null), (6), (Null) 

DROP TABLE IF EXISTS JoinTB6
CREATE TABLE JoinTB6(
ID Varchar(10)
)
INSERT INTO JoinTB6 VALUES (1), (1), (1), (1), (1), (null), (1) 


SELECT * FROM JoinTB1 
--JoinTB1--[1,2,2,3,4,5,5,6,8]
SELECT * FROM JoinTB2 
--JoinTB2--[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB3 
--JoinTB3--[1,2,2,3,3,3,4,NULL,6,NULL]
SELECT * FROM JoinTB4 
--JoinTB4--[1,1,2,3,3,4,5,7,8,NULL]
SELECT * FROM JoinTB5 
--JoinTB5--[1,1,1,1,NULL,6,NULL]
SELECT * FROM JoinTB6 
--JoinTB6--[1,1,1,1,1,NULL,1]

/*
INNER JOIN - Returns only the matching rows
LEFT JOIN / LEFT OUTER JOIN - Returns all the matching rows + non matching rows from the left table
RIGHT JOIN / RIGHT OUTER JOIN - Returns all the matching rows + non matching rows from the right table
FULL JOIN - return all rows from both tables including the non matching rows

*/
--INNER JOIN JoinTB1 & JoinTB2
--JoinTB1 - [1,2,2,3,4,5,5,6,8]
--JoinTB2 -	[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB1 
JOIN JoinTB2 
ON JoinTB1.ID = JoinTB2.ID

SELECT * FROM JoinTB1
INNER JOIN JoinTB2
ON JoinTB1.ID = JoinTB2.ID -- 10 records

SELECT COUNT(*) AS Cnt FROM JoinTB1
INNER JOIN JoinTB2
ON JoinTB1.ID = JoinTB2.ID -- 10 records

--LEFT JOIN JoinTB1 & JoinTB2
--JoinTB1 - [1,2,2,3,4,5,5,6,8]
--JoinTB2 -	[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB1 
LEFT JOIN JoinTB2 
ON JoinTB1.ID = JoinTB2.ID -- 13 records

--RIGHT JOIN JoinTB1 & JoinTB2
--JoinTB1 - [1,2,2,3,4,5,5,6,8]
--JoinTB2 -	[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB1 
RIGHT JOIN JoinTB2 
ON JoinTB1.ID = JoinTB2.ID -- 11 records

--FULL JOIN JoinTB1 & JoinTB2
--JoinTB1 - [1,2,2,3,4,5,5,6,8]
--JoinTB2 -	[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB1 
FULL JOIN JoinTB2 
ON JoinTB1.ID = JoinTB2.ID -- 14 records


--INNER JOIN JoinTB1 & JoinTB3
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB3--[1,2,2,3,3,3,4,NULL,6,NULL]
SELECT * FROM JoinTB1
INNER JOIN JoinTB3
ON JoinTB1.ID = JoinTB3.ID -- 10 records

--LEFT JOIN JoinTB1 & JoinTB3
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB3--[1,2,2,3,3,3,4,NULL,6,NULL]
SELECT * FROM JoinTB1
LEFT JOIN JoinTB3
ON JoinTB1.ID = JoinTB3.ID -- 13 records

--RIGHT JOIN JoinTB1 & JoinTB3
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB3--[1,2,2,3,3,3,4,NULL,6,NULL]
SELECT * FROM JoinTB1
RIGHT JOIN JoinTB3
ON JoinTB1.ID = JoinTB3.ID -- 12 records

--FULL JOIN JoinTB1 & JoinTB3
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB3--[1,2,2,3,3,3,4,NULL,6,NULL]
SELECT * FROM JoinTB1
FULL JOIN JoinTB3
ON JoinTB1.ID = JoinTB3.ID -- 10 records

--INNER JOIN JoinTB1 & JoinTB4
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB4--[1,1,2,3,3,4,5,7,8,NULL]
SELECT * FROM JoinTB1
INNER JOIN JoinTB4
ON JoinTB1.ID = JoinTB4.ID -- 10 records

--LEFT JOIN JoinTB1 & JoinTB4
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB4--[1,1,2,3,3,4,5,7,8,NULL]
SELECT * FROM JoinTB1
LEFT JOIN JoinTB4
ON JoinTB1.ID = JoinTB4.ID -- 11 records

--RIGHT JOIN JoinTB1 & JoinTB4
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB4--[1,1,2,3,3,4,5,7,8,NULL]
SELECT * FROM JoinTB1
RIGHT JOIN JoinTB4
ON JoinTB1.ID = JoinTB4.ID -- 12 records

--FULL JOIN JoinTB1 & JoinTB4
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB4--[1,1,2,3,3,4,5,7,8,NULL]
SELECT * FROM JoinTB1
FULL JOIN JoinTB4
ON JoinTB1.ID = JoinTB4.ID -- 13 records

--INNER JOIN JoinTB1 & JoinTB5
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB5--[1,1,1,1,NULL,6,NULL]
SELECT * FROM JoinTB1
INNER JOIN JoinTB5
ON JoinTB1.ID = JoinTB5.ID -- 5 records

--LEFT JOIN JoinTB1 & JoinTB5
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB5--[1,1,1,1,NULL,6,NULL]
SELECT * FROM JoinTB1
LEFT JOIN JoinTB5
ON JoinTB1.ID = JoinTB5.ID -- 12 records

--RIGHT JOIN JoinTB1 & JoinTB5
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB5--[1,1,1,1,NULL,6,NULL]
SELECT * FROM JoinTB1
RIGHT JOIN JoinTB5
ON JoinTB1.ID = JoinTB5.ID -- 7 records

--FULL JOIN JoinTB1 & JoinTB5
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB5--[1,1,1,1,NULL,6,NULL]
SELECT * FROM JoinTB1
FULL JOIN JoinTB5
ON JoinTB1.ID = JoinTB5.ID -- 14 records

--INNER JOIN JoinTB1 & JoinTB6
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB1
INNER JOIN JoinTB6
ON JoinTB1.ID = JoinTB6.ID -- 6 records

--LEFT JOIN JoinTB1 & JoinTB6
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB1
LEFT JOIN JoinTB6
ON JoinTB1.ID = JoinTB6.ID -- 14 records

--RIGHT JOIN JoinTB1 & JoinTB6
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB1
RIGHT JOIN JoinTB6
ON JoinTB1.ID = JoinTB6.ID -- 6 records

--FULL JOIN JoinTB1 & JoinTB6
--JoinTB1--[1,2,2,3,4,5,5,6,8]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB1
FULL JOIN JoinTB6
ON JoinTB1.ID = JoinTB6.ID -- 15 records

--INNER JOIN JoinTB1 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
INNER JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID -- 24 records

--LEFT JOIN JoinTB1 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
LEFT JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID -- 27 records

--RIGHT JOIN JoinTB1 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
RIGHT JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID -- 24 records

--FULL JOIN JoinTB1 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
FULL JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID -- 24 records

-- SELF JOIN
/*
SELF JOIN is also classified as
1. INNER SELF JOIN
2. OUTER SELF JOIN (LEFT, RIGHT & FULL)
3. CROSS SELF JOIN
*/

DROP TABLE IF EXISTS Emp
CREATE TABLE Emp(
ID INT NOT NULL,
Name Varchar(50),
Manager_ID INT
)

INSERT INTO Emp VALUES (1, 'Nikhil Jagnade', Null)
INSERT INTO Emp VALUES (2, 'Vinay Kumar', 1)
INSERT INTO Emp VALUES (3, 'Sudhir Jha', 1)
INSERT INTO Emp VALUES (4, 'Bittu Singh', 2)
INSERT INTO Emp VALUES (5, 'Harshal Jagnade', 3)
INSERT INTO Emp VALUES (6, 'Shraddha Kapoor', 3)

SELECT * FROM Emp e1
INNER JOIN Emp e2 
On e1.ID = e2.ID

SELECT e1.Name AS Manager_Name, e1.ID, e2.Name AS Employee_Name, e2.Manager_ID FROM Emp e1
INNER JOIN Emp e2
ON e1.ID = e2.Manager_ID

SELECT e.Name AS Manager_name, m.Name AS Employee_Name
FROM Emp e
INNER JOIN Emp m
ON e.ID = m.Manager_ID

SELECT e.Name AS Employee_name, m.Name AS Manager_Name
FROM Emp e
INNER JOIN Emp m
ON e.Manager_ID = m.ID

--Join Multiple tables
SELECT * FROM JoinTB1
INNER JOIN JoinTB2
ON JoinTB1.ID = JoinTB2.ID
INNER JOIN JoinTB3
ON JoinTB1.ID = JoinTB3.ID

SELECT * FROM JoinTB1
INNER JOIN JoinTB2
ON JoinTB1.ID = JoinTB2.ID
WHERE JoinTB1.ID = 1

--CROSS JOIN JoinTB1 & JoinTB2
--No ON Clause in Cartesian Product
--JoinTB1 - [1,2,2,3,4,5,5,6,8]
--JoinTB2 -	[1,2,2,3,3,3,4,6,7]
SELECT * FROM JoinTB1 
CROSS JOIN JoinTB2 --Total records 81 = 9 records * 9 records

/*
ADVANCED JOIN
LEFT JOIN - Retrive only non matching rows from left table
RIGHT JOIN - Retrive only non matching rows from right table
FULL JOIN - Retrive only non matching rows from both left and right table
*/

--LEFT JOIN JoinTB5 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
LEFT JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID
WHERE JoinTB5.ID IS NULL -- 2 records

--RIGHT JOIN JoinTB5 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]
SELECT * FROM JoinTB5
RIGHT JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID
WHERE JoinTB6.ID IS NULL -- 1 record

--FULL JOIN JoinTB5 & JoinTB6
--JoinTB5--[1,1,1,1,NULL,6,NULL]
--JoinTB6--[1,1,1,1,1,NULL,1]

SELECT * FROM JoinTB5
FULL JOIN JoinTB6
ON JoinTB5.ID = JoinTB6.ID
WHERE JoinTB5.ID IS NULL
OR JoinTB6.ID IS NULL -- 4 records