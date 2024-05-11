USE Practice_DB

/* 
FUNCTION TYPES - Aggregate, Scalar ,and table
BUILTIN Functions - Aggregate or Scalar
USER DEFINED Functions - Column, Scalar, Table

*/

DROP TABLE IF EXISTS Sales
CREATE TABLE Sales(
	TxnDate Date,
	Amount Money
)

INSERT INTO Sales VALUES ('01 Jan 2020', 500)
INSERT INTO Sales VALUES ('02 Jan 2020', 600)
INSERT INTO Sales VALUES ('03 Jan 2020', 700)
INSERT INTO Sales VALUES ('04 Jan 2020', 800)
INSERT INTO Sales VALUES ('05 Jan 2020', 900)
INSERT INTO Sales VALUES ('06 Jan 2020', 1000)
INSERT INTO Sales VALUES ('07 Jan 2020', 1100)
INSERT INTO Sales VALUES ('08 Jan 2020', 1200)
INSERT INTO Sales VALUES ('09 Jan 2020', 1300)
INSERT INTO Sales VALUES ('10 Jan 2020', 1400)

SELECT * FROM Sales
SELECT * FROM AccountMaster

--SUM()
SELECT BranchID, SUM(Balance) AS [Total Balance]
FROM AccountMaster
GROUP BY BranchID

SELECT BranchID, SUM(Balance) AS [Total Balance]
FROM AccountMaster
GROUP BY BranchID
HAVING SUM(Balance) > 70000

SELECT BranchID, SUM(Balance) AS [Total Balance]
FROM AccountMaster
GROUP BY BranchID
HAVING SUM(Balance) > 70000
ORDER BY BranchID DESC

--Running Total using SUM()
SELECT * FROM Sales

SELECT TxnDate, Amount,
					SUM(Amount) OVER (ORDER BY TxnDate) AS RunningTotal
FROM Sales

SELECT TxnDate, Amount,
					SUM(Amount) OVER (ORDER BY TxnDate) AS RunningTotal
FROM Sales
WHERE TxnDate > '05 Jan 2020'

--COUNT()
SELECT BranchID, COUNT(BranchID) AS [AccountCnt]
FROM AccountMaster
GROUP BY BranchID

SELECT BranchID, COUNT(BranchID) AS [AccCnt]
FROM AccountMaster
GROUP BY BranchID
HAVING COUNT(BranchID) > 3

SELECT BranchID, COUNT(BranchID) AS [AccCnt]
FROM AccountMaster
GROUP BY BranchID
HAVING COUNT(BranchID)>3
ORDER BY BranchID DESC

--MIN()
SELECT BranchID, MIN(Balance) AS [MinBal]
FROM AccountMaster
GROUP BY BranchID

SELECT BranchID, MIN(Balance) AS [MinBal]
FROM AccountMaster
GROUP BY BranchID
HAVING MIN(Balance) < 5000

SELECT BranchID, MIN(Balance) AS [MinBal]
FROM AccountMaster
GROUP BY BranchID
HAVING MIN(Balance) < 5000
ORDER BY BranchID DESC


--MAX()
SELECT BranchID, MAX(Balance) AS [MaxBal]
FROM AccountMaster
GROUP BY BranchID

SELECT BranchID, MAX(Balance) AS [MaxBal]
FROM AccountMaster
GROUP BY BranchID
HAVING MAX(Balance) > 50000

SELECT BranchID, Max(Balance) AS [MaxBal]
FROM AccountMaster
GROUP BY BranchID
HAVING MAX(Balance) > 50000
ORDER BY BranchID DESC


--AVG()
SELECT BranchID, AVG(Balance) AS [AVG_Bal]
FROM AccountMaster
GROUP BY BranchID

SELECT BranchID, AVG(Balance) AS [AVG_Bal]
FROM AccountMaster
GROUP BY BranchID
HAVING AVG(Balance) > 10000

SELECT BranchID, AVG(Balance) AS [AVG_Bal]
FROM AccountMaster
GROUP BY BranchID
HAVING AVG(Balance) > 10000
ORDER BY BranchID DESC

--RANKING FUNCTIONS

--ROW_NUMBER()
SELECT Name, Balance,
					ROW_NUMBER() OVER (ORDER BY Balance) AS Row_No
FROM AccountMaster

--RANK() - Skip rank
SELECT Name, Balance,
					RANK() OVER (ORDER BY Balance) As Rank_No
FROM AccountMaster

--DENSE_RANK - Do not skip rank
SELECT Name, Balance,
					DENSE_RANK() OVER (ORDER BY Balance) AS Dense_Rank_no
FROM AccountMaster

/*
LAG() and LEAD() are positional functions. 
These are window functions and are very useful in creating reports, because they can refer to data from rows above or below the current row.
*/

/*
The LAG() function allows access to a value stored in a different row above the current row. 
The row above may be adjacent or some number of rows above, as sorted by a specified column or set of columns.
syntax:
LAG(expression [,offset[,default_value]]) OVER(ORDER BY columns)
*/
SELECT TxnDate, Amount,
					LAG(Amount) OVER (ORDER BY Amount) AS Prev_Amount
FROM Sales

SELECT TxnDate, Amount,
					LAG(Amount) OVER (ORDER BY Amount) AS Prev_Amount
FROM Sales
WHERE TxnDate > '05 Jan 2020'

/*
LEAD() is similar to LAG(). Whereas LAG() accesses a value stored in a row above, LEAD() accesses a value stored in a row below.

The syntax of LEAD() is just like that of LAG():

LEAD(expression [,offset[,default_value]]) OVER(ORDER BY columns)
*/
SELECT TxnDate, Amount,
					LEAD(Amount) OVER (ORDER BY Amount) AS Next_Amount
FROM Sales

SELECT TxnDate, Amount,
					LEAD(Amount) OVER (ORDER BY Amount)
FROM Sales
WHERE TxnDate > '05 Jan 2020'

--MOVING SUM, AVERAGE USING SUM() and ROWS BETWEEN

SELECT TxnDate, Amount,  
					SUM(Amount) OVER (ORDER BY Amount ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING) AS TotalAmount
FROM Sales
WHERE Amount IS NOT NULL

SELECT TxnDate, Amount,
					SUM(Amount) OVER (ORDER BY Amount ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TotalAmt
FROM Sales
WHERE Amount IS NOT NULL

--Running SUM Forward
SELECT TxnDate, Amount,
					SUM(Amount) OVER (ORDER BY Amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Sum_Forward
FROM Sales
WHERE Amount IS NOT NULL

--Running SUM Backward
SELECT TxnDate, Amount,
					SUM(Amount) OVER (ORDER BY Amount ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS Running_Sum_Backward
FROM Sales
WHERE Amount IS NOT NULL

--TWo Days Moving Average
SELECT TxnDate, Amount,
					AVG(Amount) OVER (ORDER BY Amount ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS Two_Days_MVA
FROM Sales
WHERE Amount IS NOT NULL

--Three Days Moving Average
SELECT TxnDate, Amount,
					AVG(Amount) OVER (ORDER BY Amount ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Three_Days_MVA
FROM Sales
WHERE Amount IS NOT NULL

/*
NTILE() - Divide records in further groups
*/

CREATE TABLE SalesTB(
TxnDate DATE,
State VARCHAR(100),
City VARCHAR(100),
Amount Money
)

INSERT INTO SalesTB Values ('01 jan 2023', 'Maharashtra', 'Mumbai', 5000),
							('02 jan 2023', 'Maharashtra', 'Nagpur', 1000),
							('03 jan 2023', 'Maharashtra', 'Pune', 7000),
							('04 jan 2023', 'Maharashtra', 'Mumbai', 2000),
							('05 jan 2023', 'Maharashtra', 'Nagpur', 3000),
							('06 jan 2023', 'Maharashtra', 'Pune', 4000),
							('07 jan 2023', 'Rajasthan', 'Udaipur', 9000),
							('08 jan 2023', 'Rajasthan', 'Ajmer', 8000),
							('09 jan 2023', 'Rajasthan', 'Udaipur', 5500),
							('10 jan 2023', 'Rajasthan', 'Ajmer', 5700),
							('11 jan 2023', 'Rajasthan', 'Udaipur', 5800),
							('12 jan 2023', 'Madhya Pradesh', 'Indore', 9900),
							('13 jan 2023', 'Madhya Pradesh', 'Bhopal', 7700),
							('14 jan 2023', 'Madhya Pradesh', 'Indore', 8800),
							('15 jan 2023', 'Madhya Pradesh', 'Ujjain', 3300),
							('16 jan 2023', 'Madhya Pradesh', 'Ujjain', 4400)
							

SELECT State, City, SUM(Amount) OVER (ORDER BY Amount) AS TotalAmount
FROM SalesTB

--PARTITION BY State
SELECT State, City, SUM(Amount) OVER (PARTITION BY State ORDER BY Amount) AS TotalAmount
FROM SalesTB

--PARTITION BY State, City
SELECT State, City, SUM(Amount) OVER (PARTITION BY State, City ORDER BY Amount) AS TotalAmount
FROM SalesTB

/*
FIRST_VALUE()
LAST_VALUE()
*/
--FIRST_VALUE()
SELECT *, FIRST_VALUE(Amount) OVER (ORDER BY TxnDate) AS First_Day_Sales
FROM SalesTB --5000

--FIRST_VALUE() + PARTITION BY State
SELECT *, FIRST_VALUE(Amount) OVER (PARTITION BY State ORDER BY TxnDate) AS First_Day_Sales
FROM SalesTB--Madhya Pradesh:9000, Maharashtra:5000, Rajasthan:9000

--FIRST_VALUE() + PARTITION BY State, City
SELECT *, FIRST_VALUE(Amount) OVER (PARTITION BY State, City ORDER BY TxnDate) AS First_Day_Sales
FROM SalesTB--Madhya Pradesh:9000, Maharashtra:5000, Rajasthan:9000

--LAST_VALUE()
SELECT *, LAST_VALUE(Amount) OVER (ORDER BY TxnDate) AS Last_Day_Sales
FROM SalesTB --No correct output

SELECT *, LAST_VALUE(Amount) OVER (ORDER BY TxnDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Day_Sales
FROM SalesTB --4400

--LAST_VALUE() + PARTITION BY State
SELECT *, LAST_VALUE(Amount) OVER (PARTITION BY State ORDER BY TxnDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Day_Sales
FROM SalesTB--Madhya Pradesh:4400, Maharashtra:4000, Rajasthan:5800

--LAST_VALUE() + PARTITION BY State, City
SELECT *, LAST_VALUE(Amount) OVER (PARTITION BY State, City ORDER BY TxnDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Day_Sales
FROM SalesTB--Madhya Pradesh:9000, Maharashtra:5000, Rajasthan:9000


/*
PREDICATES - A predicate Specifies a condition that is TRUE, FALSE or UNKNOWn about a row or group
List of Predicates
1. BETWEEN - Determines whether a given value lies between two other given values that are specified in given order.
2. IN - Compare a value or values with set of values.
3. EXISTS - Tests for the existence of certain rows and result in TRUE or FALSE
4. DISTINCT - Compare a value with another value or set of values with another set of values
5. NULL - test for null values
6. LIKE - Searches for string that have a certain pattern
7. XMLEXISTS - Tests whether XQueryexpression returns a sequence of one or more items
*/
