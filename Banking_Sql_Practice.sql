USE [Practice_DB]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 19-07-2023 13:21:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AccountMaster](
	[AccNo] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Branch] [varchar](50) NULL,
	[Balance] [bigint] NULL,
	[Proudct] [varchar](50) NULL,
	[DOO] Date NULL,
	[Status] [char](1) NULL,
) ON [PRIMARY]
GO

INSERT INTO [dbo].[AccountMaster] VALUES ('Sarthak Jain', 'BR1', 770000, 'SA', '2017-01-21', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Sunil Malhotra', 'BR1', 53000, 'CA', '2018-02-07', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Shyam Jain', 'BR2', 9000, 'FD', '2019-03-12', 'O')
INSERT INTO [dbo].[AccountMaster] VALUES ('Pranay Malhotra', 'BR4', 28000, 'LA', '2020-04-09', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Karan Khurana', 'BR6', 13000, 'SA', '2020-05-05', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Sanju Jha', 'BR6', 9000, 'CA', '2020-06-17', 'O')
INSERT INTO [dbo].[AccountMaster] VALUES ('Rupesh Khurana', 'BR7', 83000, 'FD', '2021-07-30', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Aunil Jha', 'BR3', 34000, 'FD', '2021-08-29', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Surya Deulkar', 'BR5', 770000, 'LA', '2021-12-22', 'O')
INSERT INTO [dbo].[AccountMaster] VALUES ('Shardul Kane', 'BR5', 42000, 'LA', '2022-04-11', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Pooja Deulkar', 'BR3', 78600, 'LA', '2022-08-22', 'O')
INSERT INTO [dbo].[AccountMaster] VALUES ('Anjali Warn', 'BR1', 989000, 'SA', '2023-02-21', 'D')
INSERT INTO [dbo].[AccountMaster] VALUES ('Suman Bang', 'BR7', 56000, 'FD', '2023-04-01', 'O')
INSERT INTO [dbo].[AccountMaster] VALUES ('Randy Sam', 'BR7', 22000, 'FA', '2023-06-09', 'D')

Select DISTINCT AccNo FROM [dbo].[AccountMaster]

sp_rename 'AccountMaster.Branch' , 'BranchID', 'COLUMN';
sp_rename 'AccountMaster.Proudct' , 'ProductID', 'COLUMN';


CREATE TABLE [dbo].[Branch](
	[BranchID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Branch] VALUES ('BR1', 'Mumbai');
INSERT INTO [dbo].[Branch] VALUES ('BR2', 'Nagpur');
INSERT INTO [dbo].[Branch] VALUES ('BR3', 'Pune');
INSERT INTO [dbo].[Branch] VALUES ('BR4', 'Coimbatore');
INSERT INTO [dbo].[Branch] VALUES ('BR5', 'Delhi');
INSERT INTO [dbo].[Branch] VALUES ('BR6', 'Gurgao');
INSERT INTO [dbo].[Branch] VALUES ('BR7', 'Haryana');
INSERT INTO [dbo].[Branch] VALUES ('BR8', 'Banglore');
INSERT INTO [dbo].[Branch] VALUES ('BR9', 'Hyderabad');
INSERT INTO [dbo].[Branch] VALUES ('BR10', 'Ahmedabad');

SELECT * FROM Branch;

CREATE TABLE [dbo].[Product](
	[ProductID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NULL,
) ON [PRIMARY]
GO

INSERT INTO [dbo].[Product] VALUES ('CA', 'Current Account');
INSERT INTO [dbo].[Product] VALUES ('FA', 'Foreign Account');
INSERT INTO [dbo].[Product] VALUES ('FD', 'Fixed Deposit');
INSERT INTO [dbo].[Product] VALUES ('RD', 'Recurring Deposit');
INSERT INTO [dbo].[Product] VALUES ('LA', 'Loan Account');
INSERT INTO [dbo].[Product] VALUES ('SA', 'Saving Account');

SELECT * FROM Product;

CREATE TABLE [dbo].[TransactionMaster](
	[TxnID] [tinyint] IDENTITY(1,1) NOT NULL,
	[AccNo] [tinyint] NOT NULL,
	[Type] [varchar](50) NULL,
	[Amount] [bigint] NULL,
	[DOO] Date NULL,
) ON [PRIMARY]
GO

INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 1000, '2017-01-1')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CD', 770, '2017-02-2')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 1200, '2017-03-12')
INSERT INTO [dbo].[TransactionMaster] VALUES (2, 'CD', 700, '2018-04-15')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 1700, '2018-05-17')
INSERT INTO [dbo].[TransactionMaster] VALUES (3, 'CD', 2700, '2018-06-19')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 3700, '2019-07-21')
INSERT INTO [dbo].[TransactionMaster] VALUES (4, 'CD', 400, '2019-08-27')
INSERT INTO [dbo].[TransactionMaster] VALUES (2, 'CW', 7500, '2019-09-30')
INSERT INTO [dbo].[TransactionMaster] VALUES (5, 'CD', 600, '2017-10-2')
INSERT INTO [dbo].[TransactionMaster] VALUES (5, 'CW', 6700, '2017-11-1')
INSERT INTO [dbo].[TransactionMaster] VALUES (6, 'CD', 7800, '2018-12-2')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 1, '2018-01-3')
INSERT INTO [dbo].[TransactionMaster] VALUES (7, 'CD', 77, '2017-02-4')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 700, '2019-03-5')
INSERT INTO [dbo].[TransactionMaster] VALUES (8, 'CD', 300, '2020-04-8')
INSERT INTO [dbo].[TransactionMaster] VALUES (1, 'CW', 800, '2020-05-11')
INSERT INTO [dbo].[TransactionMaster] VALUES (9, 'CW', 900, '2020-06-12')
INSERT INTO [dbo].[TransactionMaster] VALUES (9, 'CD', 8800, '2021-07-17')
INSERT INTO [dbo].[TransactionMaster] VALUES (10, 'CW', 9900, '2021-08-21')
INSERT INTO [dbo].[TransactionMaster] VALUES (7, 'CD', 6600, '2021-09-19')
INSERT INTO [dbo].[TransactionMaster] VALUES (2, 'CW', 4400, '2022-10-13')
INSERT INTO [dbo].[TransactionMaster] VALUES (3, 'CD', 70, '2022-11-22')
INSERT INTO [dbo].[TransactionMaster] VALUES (8, 'CW', 40, '2022-12-24')
INSERT INTO [dbo].[TransactionMaster] VALUES (8, 'CD', 800, '2023-01-26')
INSERT INTO [dbo].[TransactionMaster] VALUES (7, 'CW', 7700, '2023-02-29')
INSERT INTO [dbo].[TransactionMaster] VALUES (6, 'CD', 5600, '2023-03-30')
INSERT INTO [dbo].[TransactionMaster] VALUES (11, 'CW', 34700, '2023-04-30')

SELECT * FROM TransactionMaster
--Select Clause is use to filter or eliminate columns

-- create Duplicate table
CREATE TABLE DuplicateAccountMaster AS (SELECT * FROM AccountMaster WHERE 1=2);

SELECT * FROM NewAccountMaster;

--Derived table
SELECT * FROM (SELECT * FROM AccountMaster) AS AccountMaster2;

-- Copy table schema only
SELECT * FROM AccountMaster
WHERE 1=2;

-- Select top 10 rows
SELECT TOP 10 * FROM AccountMaster;

-- Who has highest balance in bank account (Highest Balance + Who has it)
SELECT * FROM AccountMaster
WHERE Balance = (SELECT MAX(Balance) FROM AccountMaster);

SELECT * FROM AccountMaster
WHERE Balance = (SELECT MAX(BALANCE) FROM AccountMaster
WHERE Balance < (SELECT MAX(Balance) FROM AccountMaster));

SELECT 5;

SELECT 5 AS Number;

SELECT 'Java' AS CourseName;

SELECT 'Java' AS CourseName, 50 AS Marks;

SELECT 'Mr.Nikhil Jagnade' AS Name, 'Google' AS Company, 1200000 AS Salary;

SELECT Name, 5 AS Number FROM AccountMaster;

SELECT *, 5 FROM AccountMaster;

SELECT Name, 'Google' AS Company FROM AccountMaster;

SELECT 'Mr.' AS Prefix , Name, ' is working in Google Company and account balance is' AS WorkingStatus, Balance FROm AccountMaster;

SELECT * FROM AccountMaster

SELECT *, * FROM AccountMaster

SELECT Name, Branch, Name, Branch, * FROM AccountMaster

SELECT Name AS CustomerName FROM AccountMaster

SELECT Name CustomerName FROM AccountMaster

--SELECT Name AS Customer Name FROM AccountMaster (syntax error)

SELECT Name AS 'Customer Name' FROM AccountMaster

SELECT Name 'Customer Name' FROM AccountMaster

SELECT Name AS [Customer Name] FROM Accountmaster

SELECT Name [Customer Name] FROM Accountmaster

SELECT CustomerName = Name FROM AccountMaster

--SELECT Customer Name = Name FROM AccountMaster (syntax error)

SELECT [Customer Name] = Name FROM AccountMaster

SELECT 'Customer Name' = Name FROM AccountMaster

SELECT Name AS CustomerName, Balance AS AccBalance FROM AccountMaster

SELECT Name CustomerName, Balance AccBalance FROM AccountMaster

SELECT *, Name AS CustomerName, Balance AS AccBalance FROM AccountMaster

SELECT CustomerName = Name, AccBalance = Balance FROM AccountMaster

SELECT CustomerName = Name, AccBalance = Balance, * FROM AccountMaster

---WHERE Clause is used to filter or eliminate rows/records

SELECT * 
FROM AccountMaster
WHERE Balance > 10000;

SELECT AccNo, Name 
FROM AccountMaster
WHERE Branch = 'BR1';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch = 'BR1';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch <> 'BR1';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch = 'BR1' AND Branch = 'BR2';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch = 'BR1' OR Branch = 'BR2';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch = 'BR1' AND Balance > 5000;

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch IN ('BR1', 'BR7');

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch NOT IN ('BR1', 'BR7');

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch IS Null;

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch IS NOT Null;

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch LIKE '%1%';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch LIKE 'BR%';

SELECT AccNo, Name AS CustomerName, Branch
FROM AccountMaster
WHERE Branch LIKE '%7';

-- ORDER BY Clause sort data in ASC (Default) or DESC format
-- ORDER BY Clause is used to get the sorted records on one or more columns in ascending and descending order
-- ORDER BY Clause must come after the WHERE, GROUP BY and HAVING Clause if present in the query

SELECT * 
FROM AccountMaster
ORDER BY Name;

SELECT * 
FROM AccountMaster
ORDER BY AccNo DESC;

SELECT * 
FROM AccountMaster
ORDER BY Name, Branch;

SELECT * 
FROM AccountMaster
ORDER BY Name DESC, Branch;

--SELECT, WHERE, and ORDER BY Clause

SELECT * 
FROM AccountMaster
WHERE Branch = 'BR1'
ORDER BY Name DESC;

SELECT * 
FROM AccountMaster
WHERE Branch = 'BR1' AND Balance > 900
ORDER BY Name DESC;

-- SELECT, WHERE, GROUP BY (Group records and perform aggregations), and ORDER BY Clause

SELECT Branch, Count(*) AS Cnt 
FROM AccountMaster
GROUP BY Branch
ORDER BY Branch DESC;

SELECT Name, Branch, Count(*) AS Cnt 
FROM AccountMaster
WHERE Name LIKE '%a%'
GROUP BY Name, Branch
ORDER BY Branch DESC;

SELECT Branch, Sum(Balance) As TotalBalance
FROM AccountMaster
GROUP BY Branch
ORDER BY Branch;

SELECT Branch, Count(*) AS Cnt 
FROM AccountMaster
WHERE Branch IN ('BR1', 'BR2', 'BR3', 'BR4', 'BR5')
GROUP BY Branch
HAVING Count(*) > 1
ORDER BY Branch DESC;

SELECT Branch, Proudct, Count(*) AS Cnt 
FROM AccountMaster
WHERE Branch IN ('BR1', 'BR2', 'BR3', 'BR4', 'BR5')
GROUP BY Branch, Proudct
ORDER BY Branch;

-- GROUP BY Clause is use to group records and perform aggregations

--error Column 'AccountMaster.AccNo' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
SELECT *, COUNT(*) AS Cnt
FROM AccountMaster
GROUP BY Branch;

SELECt Branch, COUNT(*)
FROM AccountMaster
GROUP BY Branch;

SELECt Branch, Proudct, COUNT(*)
FROM AccountMaster
GROUP BY Branch, Proudct;

-- error all columns present in select clause should present in GROUP BY Clause
SELECT Branch, Proudct, COUNT(*)
FROM AccountMaster
GROUP BY Branch;

SELECT Branch, Proudct, Status, COUNT(*) AS Cnt
FROM AccountMaster
GROUP BY Branch, Proudct, Status;

SELECT Branch, Proudct, Status, COUNT(*) AS Cnt
FROM AccountMaster
WHERE Branch IN ('BR1', 'BR2', 'BR3')
GROUP BY Branch, Proudct, Status;

SELECT Branch, Proudct, Status, COUNT(*) AS Cnt
FROM AccountMaster
WHERE Branch NOT IN ('BR2')
GROUP BY Branch, Proudct, Status
ORDER BY Branch;

SELECT Branch, Proudct, Status, COUNT(*) AS Cnt
FROM AccountMaster
WHERE Branch NOT IN ('BR2')
GROUP BY Branch, Proudct, Status
Having COUNT(*) > 1
ORDER BY Branch;

SELECT Branch, Proudct, Status, SUM(Balance) AS Cnt
FROM AccountMaster
WHERE Branch NOT IN ('BR2')
GROUP BY Branch, Proudct, Status
Having SUM(Balance) > 100
ORDER BY Branch;

--Date Functions in SQL

SELECT * FROM AccountMaster;

SELECT DOO, YEAR(DOO) As Year FROM AccountMaster;
SELECT DOO, MONTH(DOO) As Month FROM AccountMaster;
SELECT DOO, DAY(DOO) AS Day FROM AccountMaster;

SELECT DATEPART(YY, GETDATE()) AS Current_Year;
SELECT DATEPART(MM, GETDATE()) AS Current_Month;
SELECT DATEPART(DD, GETDATE()) AS Current_Day;

SELECT DATENAME(MM, GETDATE()) AS Month_Name; -- July
SELECT DATENAME(DD, GETDATE()) AS Day_Name; -- 19
SELECT DATENAME(DW, GETDATE()) AS Day_Name; -- Wednesday
SELECT DATENAME(YY, GETDATE()) AS Day_Name; -- 2023

SELECT CURDATE();--error 'CURDATE' is not a recognized built-in function name.
SELECT NOW(); --error 'NOW' is not a recognized built-in function name.

SELECT GETDATE();
SELECT GETDATE() AS TodayDate;
SELECT GETDATE() - 1 AS YesterdayDate;
SELECT GETDATE() + 1 AS TomorrowDate;

SELECT DATEDIFF(YY, '1992/09/21', GETDATE()) AS AgeInYears;
SELECT DATEDIFF(MM, '1992/09/21', GETDATE()) As AgeInMonths;
SELECT DATEDIFF(DD, '1992/09/21', GETDATE()) As AgeInDays;

--Get Account age from Accountmaster
SELECT Name, DOO, DATEDIFF(YY, DOO, GETDATE()) AS AccAgeInYears FROM AccountMaster;

-- Customers opened account in the current year
SELECT Name, DOO, DATEDIFF(YY, DOO, GETDATE()) AS Age 
FROM AccountMaster
WHERE DATEDIFF(YY, DOO, GETDATE()) = 0;

-- Customers opened account in the last year
SELECT Name, DOO, DATEDIFF(YY, DOO, GETDATE()) AS Age 
FROM AccountMaster
WHERE DATEDIFF(YY, DOO, GETDATE()) = 1;

-- Customers opened account in the last three year
SELECT Name, DOO, DATEDIFF(YY, DOO, GETDATE()) AS Age 
FROM AccountMaster
WHERE DATEDIFF(YY, DOO, GETDATE()) <= 3;

--ISNULL() -- It replace null values in column with any constant value such as 0

SELECt AccNo, Name, Branch, ISNULL(Balance, 0) AS New_Balance FROM AccountMaster;

--CASE STATEMENT
SELECT Name, Balance,
					CASE WHEN Balance > 10000 THEN 'Diamond'
						 WHEN Balance BETWEEN 5000 AND 10000 THEN 'Gold'
						 WHEN Balance BETWEEN 2000 AND 5000 THEN 'Silver'
						 ELSE 'Platinum'
					END AS CustomerCategory
FROM AccountMaster;

SELECT Name, Balance,
					CASE WHEN Balance > 10000 THEN 'Diamond'
						 WHEN Balance BETWEEN 5000 AND 10000 THEN 'Gold'
						 WHEN Balance BETWEEN 2000 AND 5000 THEN 'Silver'
						 ELSE 'Platinum'
					END 
FROM AccountMaster;

SELECT Name, Balance, CustomerCategory =
					CASE WHEN Balance > 10000 THEN 'Diamond'
						 WHEN Balance BETWEEN 5000 AND 10000 THEN 'Gold'
						 WHEN Balance BETWEEN 2000 AND 5000 THEN 'Silver'
						 ELSE 'Platinum'
					END
FROM AccountMaster;

-- Subquery - A query in the WHERE Clause

--Who has the highest balance (Highest Balance + Who has it)
--1. What is the Highest Balance?
SELECT MAX(Balance) FROM AccountMaster;

--2. Who has it
SELECT * FROM AccountMaster 
WHERE Balance = (SELECT MAX(Balance) FROM AccountMaster);

SELECT DISTINCT Name, Balance FROM AccountMaster 
WHERE Balance = (SELECT MAX(Balance) FROM AccountMaster);

--Who has the second highest balance?
SELECT * FROM AccountMaster 
WHERE Balance = (SELECT MAX(Balance) FROM AccountMaster 
	WHERE Balance < (SELECT MAX(Balance) FROM AccountMaster)
);

-- Who has lowest balance?
SELECT * FROM AccountMaster
WHERE Balance = (SELECT MIN(Balance) FROM AccountMaster);

-- Who has second lowest balance?
SELECT * FROM AccountMaster
WHERE Balance = (SELECT MIN(Balance) FROM AccountMaster
	WHERE Balance > (SELECT MIN(Balance) FROM AccountMaster)
);

-- Top 5 Balance
SELECT * FROM AccountMaster
WHERE Balance IN (SELECT TOP 5 Balance 
					FROM AccountMaster 
					ORDER BY Balance DESC);

-- Who has 5th Highest balance
Select * FROM AccountMaster
WHERE Balance = (SELECT MAX(Balance) FROM AccountMaster 
					WHERE Balance IN (SELECT TOP 5 Balance FROM AccountMaster ORDER BY Balance DESC)
				);

--OPERATORS IN SUBQUERY (==, IN, EXISTS() )
SELECT * FROM AccountMaster
WHERE Balance = (SELECT MIN(Balance) FROM AccountMaster);

SELECT * FROM AccountMaster
WHERE Balance IN (SELECT TOP 3 Balance FROM AccountMaster);

SELECT * FROM AccountMaster
WHERE Balance EXISTS (SELECT Name, Balance FROM AccountMaster);

--CORRELATED SUBQUERY -> Works Like Loop Inside Loop
SELECT * FROM AccountMaster AS AM
WHERE EXISTS ( SELECT * FROM TransactionMaster AS TM
				WHERE AM.AccNo = TM.AccNo );

--Join
--Need to specify the tablename for same column name in both the tables
SELECT AccNo, Name, AccNo, Amount 
FROM AccountMaster AM JOIN TransactionMaster TM
ON AM.AccNo = TM.AccNo;

SELECT AM.AccNo, AM.Name, TM.AccNo, TM.Amount 
FROM AccountMaster AM JOIN TransactionMaster TM
ON AM.AccNo = TM.AccNo;

--INNER JOIN
SELECT *
FROM AccountMaster AM INNER JOIN TransactionMaster TN
ON AM.AccNo = TN.AccNo;

--LEFT OUTER JOIN
SELECT *
FROM AccountMaster AM LEFT JOIN TransactionMaster TN
ON AM.AccNo = TN.AccNo;

--RIGHT OUTER JOIN
SELECT *
FROM AccountMaster AM RIGHT JOIN TransactionMaster TN
ON AM.AccNo = TN.AccNo;

--FULL OUTER JOIN
SELECT *
FROM AccountMaster AM FULL JOIN TransactionMaster TN
ON AM.AccNo = TN.AccNo;

--CARTESION JOIN
SELECT * FROM AccountMaster, TransactionMaster;

--UNION - No common columns between both the tables but both tables should have equal no of coulmns with same datatype
--error - All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT * FROM AccountMaster
UNION
SELECT * FROM TransactionMaster

SELECT AccNo FROM AccountMaster
UNION
SELECT AccNo FROM TransactionMaster

--UNION ALL
SELECT AccNo FROM AccountMaster
UNION ALL
SELECT AccNo FROM TransactionMaster

--CORRELATED SUBQUERY

--List Account holder have done transactions
SELECT * FROM AccountMaster AS AM
WHERE EXISTS(
				SELECT * FROM TransactionMaster AS TM
				WHERE AM.AccNo = TM.AccNo
			)

--List Account holder who have not done transactions
SELECT * FROM AccountMaster AS AM
WHERE NOT EXISTS(
					SELECT * FROM TransactionMaster AS TM
					WHERE AM.AccNo = TM.AccNo
				)

-- List AccNo wise No Of Transactions where acc holder has done more than 1 transactions
SELECT AccNo, COUNT(*) AS [No Of Txn]
FROM TransactionMaster
GROUP BY AccNo
HAVING COUNT(*) > 1;

-- List AccNo and Name wise No Of Transactions where acc holder has done more than 1 transactions
SELECT AM.AccNo, Name, COUNT(*) AS [No Of Txn] 
FROM AccountMaster AS AM JOIN TransactionMaster AS TM 
ON AM.AccNo = TM.AccNo
GROUP BY AM.AccNo, Name
HAVING COUNT(*) > 1;

--DERIVED TABLE QUERY to optimize performance
SELECT AM.AccNo, Name, Cnt
FROM AccountMaster AS AM JOIN (
								SELECT AccNo, COUNT(*) AS Cnt
								FROM TransactionMaster
								GROUP BY AccNo
								HAVING COUNT(*) > 1
							  ) AS K
						ON AM.AccNo = K.AccNo

--CUBE Operator - All permutations and combinations 
SELECT Name, BranchID, SUM(Balance) AS TotalBal 
FROM AccountMaster
GROUP BY Name, BranchID WITH CUBE


--ROLLUP Operator - Less no of permutations and combinations 
SELECT Name, BranchID, SUM(Balance) AS TotalBal 
FROM AccountMaster
GROUP BY Name, BranchID WITH ROLLUP

--ROW_NUMBER()
SELECT *, ROW_NUMBER() OVER ( ORDER BY Balance DESC) AS Row_No 
FROM AccountMaster;

SELECT AccNo, Name, Balance, ROW_NUMBER() OVER ( ORDER BY Balance DESC) AS Row_No 
FROM AccountMaster;

SELECT AccNo, Name, Balance, BranchID, ROW_NUMBER() OVER ( PARTITION BY BranchID ORDER BY Balance DESC) AS Row_No 
FROM AccountMaster;

--RANK()
SELECT AccNo, Name, Balance, RANK() OVER ( ORDER BY Balance DESC) AS Rank_No
FROM AccountMaster;

SELECT AccNo, Name, Balance, RANK() OVER ( ORDER BY Balance ASC) AS Rank_No
FROM AccountMaster;

SELECT AccNo, Name, Balance, BranchID, RANK() OVER (PARTITION BY BranchID ORDER BY Balance DESC) AS Rank_No
FROM AccountMaster