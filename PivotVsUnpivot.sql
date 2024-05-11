USE Practice_DB

--PIVOT & UNPIVOT
DROP TABLE IF EXISTS Pivot_TB
CREATE TABLE Pivot_TB(
	Col_1 VARCHAR(50),
	[1] INT,
	[2] INT,
	[3] INT,
	[4] INT,
	[5] INT
	)

INSERT INTO Pivot_TB VALUES ('Col_2', 776, 856, 453, 879, 890)

SELECT * FROM Pivot_TB

/* PIVOT - SYNTAX

SELECT * 
FROM
	(
		Subquery - Sourcequery
	) AS SourceTB
PIVOT
	(
		Aggregate Function
	    FOR [ColumnName] 
	    IN ([Col_1], [Col_2])
	
	) AS PivotTB

*/

--Solution
SELECT [Col_3] AS Col_1, [Col_2]
FROM Pivot_TB
UNPIVOT
	( 
		[Col_2]
		FOR [Col_3] 
		IN ([1], [2], [3], [4], [5])
	) AS UnPivot_tb


SELECT * FROM Pivot_TB

SELECT * FROM Emp1

SELECT [City], [Nagpur], [Pune], [Mumbai] 
FROM
	(SELECT City AS CityCol, Salary
	FROM Emp1) AS SourceTB
	PIVOT
	 ( 
	   SUM(Salary)
	   FOR [CityCol] 
	   IN ([City] , [Nagpur], [Pune], [Mumbai])
	 ) AS Pivot_tb1

DROP TABLE IF EXISTS SalesTB2
CREATE TABLE SalesTB2(
TxnDate DATE,
Customer_ID VARCHAR(10),
Product_ID VARCHAR(10),
State VARCHAR(50),
City VARCHAR(50),
Amount MONEY
)

INSERT INTO SalesTB2 VALUES ('01 Jan 2020', 'CUST01', 'P1', 'Maharashtra', 'Nagpur', 500),
							('05 Jan 2020', 'CUST02', 'P2', 'Maharashtra', 'Mumbai', 600),
							('10 Jan 2020', 'CUST03', 'P3', 'Maharashtra', 'Pune', 700),
							('15 Jan 2020', 'CUST04', 'P4', 'Maharashtra', 'Nagpur', 400),
							('20 Jan 2020', 'CUST05', 'P5', 'Maharashtra', 'Nagpur', 550),
							('01 Feb 2020', 'CUST01', 'P1', 'Maharashtra', 'Nagpur', 100),
							('05 feb 2020', 'CUST02', 'P2', 'Maharashtra', 'Mumbai', 200),
							('10 Feb 2020', 'CUST03', 'P3', 'Maharashtra', 'Pune', 300),
							('15 Feb 2020', 'CUST04', 'P4', 'Maharashtra', 'Nagpur', 400),
							('20 Feb 2020', 'CUST05', 'P5', 'Maharashtra', 'Nagpur', 150),
							('01 March 2020', 'CUST01', 'P1', 'Maharashtra', 'Nagpur', 50),
							('05 March 2020', 'CUST02', 'P2', 'Maharashtra', 'Mumbai', 60),
							('10 March 2020', 'CUST03', 'P3', 'Maharashtra', 'Pune', 70),
							('15 March 2020', 'CUST04', 'P4', 'Maharashtra', 'Nagpur', 40),
							('20 March 2020', 'CUST05', 'P5', 'Maharashtra', 'Nagpur', 55),
							('01 April 2020', 'CUST01', 'P1', 'Maharashtra', 'Nagpur', 590),
							('05 April 2020', 'CUST02', 'P2', 'Maharashtra', 'Mumbai', 690),
							('10 April 2020', 'CUST03', 'P3', 'Maharashtra', 'Pune', 790),
							('15 April 2020', 'CUST04', 'P4', 'Maharashtra', 'Nagpur', 490),
							('20 April 2020', 'CUST05', 'P5', 'Maharashtra', 'Nagpur', 559)

SELECT * FROM SalesTB2

--Pivot Table SalesTB2
--MonthWise Sales
SELECT [Jan-20], [Feb-20], [Mar-20], [Apr-20]
FROM
	(
		SELECT FORMAT(TxnDate, 'MMM-yy') AS SalesMonth,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [SalesMonth]
		IN ([Jan-20], [Feb-20], [Mar-20], [Apr-20])
	) AS PivotTB

--Customer wise sales
SELECT [Cust01], [Cust02], [Cust03], [Cust04], [Cust05]
FROM
	(
		SELECT Customer_ID AS Customer,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [Customer]
		IN ([Cust01], [Cust02], [Cust03], [Cust04], [Cust05])
	) AS PivotTB

--Product wise sales
SELECT [P1], [P2], [P3], [P4], [P5]
FROM
	(
		SELECT Product_ID AS Product,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [Product]
		IN ([P1], [P2], [P3], [P4], [P5])
	) AS PivotTB

--Customer & Product wise sales
SELECT Customer, ISNULL(P1, 0) AS P1, ISNULL(P2, 0) AS P2, ISNULL(P3, 0) AS P3, ISNULL(P4, 0) AS P4, ISNULL(P5, 0) AS P5 
FROM
	(
		SELECT Product_ID AS Product,
		Customer_ID AS Customer,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [Product]
		IN ([P1], [P2], [P3], [P4], [P5])
	) AS PivotTB

--Customer, City,  & Product wise sales
SELECT Customer, City, ISNULL(P1, 0) AS P1, ISNULL(P2, 0) AS P2, ISNULL(P3, 0) AS P3, ISNULL(P4, 0) AS P4, ISNULL(P5, 0) AS P5 
FROM
	(
		SELECT Product_ID AS Product,
		Customer_ID AS Customer,
		City,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [Product]
		IN ([P1], [P2], [P3], [P4], [P5])
	) AS PivotTB
ORDER BY Customer ASC

--Customer, City, Month, & Product wise sales
SELECT Customer, City, Sales_Month, ISNULL(P1, 0) AS P1, ISNULL(P2, 0) AS P2, ISNULL(P3, 0) AS P3, ISNULL(P4, 0) AS P4, ISNULL(P5, 0) AS P5 
FROM
	(
		SELECT Product_ID AS Product,
		Customer_ID AS Customer,
		City,
		FORMAT(TxnDate, 'MMM') AS Sales_Month,
		Amount
		FROM SalesTB2
	) AS SourceTB
PIVOT
	(
		SUM(Amount)
		FOR [Product]
		IN ([P1], [P2], [P3], [P4], [P5])
	) AS PivotTB
ORDER BY Customer ASC

