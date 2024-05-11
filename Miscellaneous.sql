USE Practice_DB

--Rollback deleted transactions
SELECT * FROM TransactionMaster WHERE TxnID = 26
Begin Transaction
ROLLBACK
SELECT * FROM TransactionMaster

--Table schema definition
/*
sp_help spName --Display definition of SP object
sp_helptext spName -- Display text of the SP object
sp_depends spName --Display dependability of SP on ther database objects like tables/views/function [We can't delete these objects until we drop SP]

sp_help tableName --Dsiplay definition/schema of table
sp_helptext tablename --Error:There is no text for object 'tableName'.
sp_depends tableName --Display all the dependencies with other tables, sp, views, functions etc

*/
SP_HELP 'AccountMaster'
sp_helptext 'AccountMaster' -- Error:There is no text for object 'AccountMaster'.
sp_depends 'AccountMaster' -- Display the text inside sp
AccountMaster -- Select & PRESS -> ALT + F1 /to display database object schema like sp_help AccountMaster

--Replace NULL Values with ISNULL(), COALESCE(), CASE Statement

DROP TABLE IF EXISTS NullTB
CREATE TABLE NullTB(
ID INT,
Name VARCHAR(20),
Salary NUMERIC
)

INSERT INTO NullTB VALUES(1, 'Nikhil J', Null)
INSERT INTO NullTB VALUES(2, 'Harshal J', 1000)
INSERT INTO NullTB VALUES(3, 'Praful J', Null)
INSERT INTO NullTB VALUES(4, 'Vinay J', 5000)
INSERT INTO NullTB VALUES(5, 'Suraj J', Null)
INSERT INTO NullTB VALUES(6, 'Akshay J', 4000)

SELECT * FROM NullTB

--ISNULL(ColumnName, ReplaceValue)
SELECT *, ISNULL(Salary,0) AS New_Salary
FROM NullTB

--COALESCE(ColumnName, ReplaceValue)
SELECT *, COALESCE(Salary, 0) AS New_Salary 
FROM NullTB

--CASE Statement
SELECT *, 
	CASE WHEN Salary IS NULL THEN 0
	ELSE Salary  
	END as New_Salary 
FROM  NullTB

/*
COALESCE () - Returns the first non NULL value
*/

CREATE TABLE NameTB(
ID INT IDENTITY(1,1) NOT NULL,
First_Name VARCHAR(50),
Middle_Name VARCHAR(50),
Last_Name VARCHAR(50)
)

INSERT INTO NameTB VALUES ('Nikhil', NULL, NULL),
							(NULL, 'Pralhad', NULL),
							(NULL, NULL, 'Jagnade'),
							(NULL, 'Vinay', NULL)

--COALESCE () -- Returns only first non null value
SELECT ID, COALESCE(First_Name, Middle_Name, Last_Name) AS Name 
FROM NameTB

/* Table Column Details */

SELECT * FROM information_schema.columns 
FROM table_name = 'NameTB'

sp_help 'NameTB'

CREATE TABLE Orders_TB(
OrderID INT IDENTITY NOT NULL,
Products VARCHAR(50)
)
INSERT INTO Orders_TB VALUES('Apple'), ('Orange'), ('Banana'), ('Apple, Banana'), ('Kiwi'), ('Watermelon'), ('Orange, Grapes')

CREATE TABLE Returns_TB(
ReturnID INT IDENTITY NOT NULL,
OrderID INT
)
INSERT INTO Returns_TB VALUES(2), (4) 

SELECT * FROM Orders_TB
SELECT * FROM Returns_TB

SELECT
	OrderID, Products
FROM
	Orders_TB
WHERE
	OrderID NOT IN (SELECT OrderID FROM Returns_TB)