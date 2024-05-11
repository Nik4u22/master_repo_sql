USE Practice_DB

/*
VARIABLE - Varibale is capable of storing value in memory
TWO TYPES - Local & Global
*/

DECLARE @a INT = 20
PRINT @a

DECLARE @x INT, @y INT, @z INT
SET @x = 10
SET @y = 20

SET @z = @x + @y

--PRINT always display data in Messages
PRINT @z
PRINT @x + @y
PRINT 'Total = '+CAST(@z AS VARCHAR)

--SELECT always display data as Resultset
SELECT @x + @y AS Total

--SP to calculate product
CREATE PROCEDURE sp_product(
	@x INT,
	@y INT
)
AS
BEGIN
	PRINT 'Product = '+CAST(@x * @y AS VARCHAR)
END

EXEC sp_product @x=20, @y=30

--sp for people who haven't done transactions in last 6 month & Marke thse accounts Inoperative

UPDATE accountmaster
SET status = 'D'
WHERE accno in (
					SELECT
						accno
					FROM
						accountmaster
					WHERE
						accno not in (SELECT accno FROM TransactionMaster WHERE DATEDIFF(mm, doo, GETDATE()) <= 6)
				)

--View all tables present in database
SELECT
	*
FROM
	sys.tables

--Query to select data from tables
SELECT
	'SELECT * FROM '+name
FROM
	sys.tables

--SELECT * FROM NameTB
--SELECT * FROM Emp1
--SELECT * FROM Emp2
--SELECT * FROM Department
--SELECT * FROM IndexTB
--SELECT * FROM SalesTB2
--SELECT * FROM Pivot_TB
--SELECT * FROM Customer
--SELECT * FROM ADO NET Destination
--SELECT * FROM AccountMaster
--SELECT * FROM NewAccountMaster
--SELECT * FROM Branch
--SELECT * FROM Product
--SELECT * FROM TransactionMaster
--SELECT * FROM JoinTB1
--SELECT * FROM JoinTB2
--SELECT * FROM JoinTB3
--SELECT * FROM JoinTB4
--SELECT * FROM JoinTB5
--SELECT * FROM JoinTB6
--SELECT * FROM Emp
--SELECT * FROM NullTB
--SELECT * FROM Sales

--View all views
SELECT
	*
FROM
	sys.views

--Query to select views
SELECT
	'SELECT * FROM '+name
FROM
	sys.views

--View all stored procedures
SELECT
	*
FROM
	sys.procedures

--Query to get Exec procedures statement for all stored procedures
SELECT
	'EXEC '+name
FROM
	sys.procedures

--EXEC spGetAccDetailsByBranchAndBalance
--EXEC spGetAccCountByBranch
--EXEC spGetAccountCnt
--EXEC spGetAccountName
--EXEC spCreateTempTable
--EXEC sp_getAllAccounts

/*
CODE REUSEABILITY - VARIABLES
*/

DECLARE @AccNo INT
SET @AccNo = 60

--current month transactions by accountholder
SELECT
	COUNT(*) AS No_Of_Txn
FROM
	TransactionMaster
WHERE
	DATEDIFF(mm, doo, GETDATE()) = 0
	AND AccNo = @AccNo

--Last three Month transaction by accountholder
SELECT
	COUNT(*) AS No_Of_Txn
FROM 
	TransactionMaster
WHERE
	DATEDIFF(mm, doo, GETDATE()) <= 2
	AND AccNo = @AccNo

--current year transactions by accountholder
SELECT
	COUNT(*) AS No_Of_Txn
FROM
	TransactionMaster
WHERE
	DATEDIFF(yy, doo, GETDATE()) = 0
	AND AccNo = @AccNo

--last 30 year transactions by accountholder
SELECT
	COUNT(*) AS No_Of_Txn
FROM
	TransactionMaster
WHERE
	DATEDIFF(yy, doo, GETDATE()) <= 29
	AND AccNo = @AccNo

--USING STORED PROCEDURE

ALTER PROCEDURE sp_getAccTxnCnt(
	@AccNo INT
)
AS
BEGIN
	--Check AccNo
	IF EXISTS(SELECT * FROM AccountMaster WHERE AccNo = @AccNo)
		BEGIN
			PRINT 'AccNo is valid'
			--current month transactions by accountholder
			SELECT
				COUNT(*) AS No_Of_Txn
			FROM
				TransactionMaster
			WHERE
				DATEDIFF(mm, doo, GETDATE()) = 0
				AND AccNo = @AccNo

			--Last three Month transaction by accountholder
			SELECT
				COUNT(*) AS No_Of_Txn
			FROM 
				TransactionMaster
			WHERE
				DATEDIFF(mm, doo, GETDATE()) <= 2
				AND AccNo = @AccNo

			--current year transactions by accountholder
			SELECT
				COUNT(*) AS No_Of_Txn
			FROM
				TransactionMaster
			WHERE
				DATEDIFF(yy, doo, GETDATE()) = 0
				AND AccNo = @AccNo

			--last 30 year transactions by accountholder
			SELECT
				COUNT(*) AS No_Of_Txn
			FROM
				TransactionMaster
			WHERE
				DATEDIFF(yy, doo, GETDATE()) <= 29
				AND AccNo = @AccNo
		END
	ELSE
		BEGIN
		 PRINT 'Invalid AccNo'
		END
END

EXEC sp_getAccTxnCnt @AccNo = 60

/* WHILE LOOP - FOR LOOP does not support in SQL */

CREATE PROCEDURE sp_printNo
AS
BEGIN
	DECLARE @x INT
	SET @x = 1 --Initialization

	WHILE(@x < 10) --Condition
	BEGIN
		PRINT @x
		SET @x = @x + 1 --Increment/Decrement

	END
END

EXEC sp_printNo

--SP to insert 1-100 number via loop
CREATE TABLE table_tb(
ID INT
)

CREATE PROCEDURE sp_insertNo
AS
BEGIN
	DECLARE @i INT = 1 --initialization

	WHILE(@i <=100)--Condition
	BEGIN
		INSERT INTO table_tb VALUES(@i) --insert
		SET @i = @i + 1 -- increment/decrement
	END
END

--EXEC sp
EXEC sp_insertNo

--Select data from table
SELECT 
	* 
FROM
	table_tb