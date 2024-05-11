USE Practice_DB

SELECT * FROM AccountMaster

SELECT * FROM TransactionMaster

--List accountholders who have done transaction
--QUERY-1 --Used Join After DerivedTB
SELECT
	DISTINCT AM.AccNo,
	AM.Name
FROM
	(
		SELECT 
			AccNo
		FROM
			TransactionMaster
	) AS DevTb
JOIN
	AccountMaster AS AM
	ON AM.AccNo = DevTb.AccNo

--QUERY 2 --Used join before DerivedTB
SELECT
	DISTINCT AM.AccNo,
	AM.Name
FROM
	AccountMaster AS AM
	JOIN (SELECT 
			AccNo
		  FROM
			TransactionMaster) AS DevTb
ON
	AM.AccNo = DevTb.AccNo

--List accountholders who have done at max 2 transaction in year 2019 with TxnCnt and TotalAmount
SELECT
	AM.AccNo,
	AM.Name,
	TxnCnt,
	TotalAmount
FROM 
	AccountMaster AS AM
JOIN (
		SELECT
			AccNo,
			Count(*) AS TxnCnt,
			Sum(Amount) AS TotalAmount
		FROM
			TransactionMaster
		WHERE
			YEAR(DOO) = '2019'
		GROUP BY
			AccNo
		HAVING
			Count(*) < 3 
	  ) AS DervTB
ON
	AM.AccNo = DervTB.AccNo

--Another way to write same query
SELECT
	AM.AccNo,
	AM.Name,
	(SELECT Count(*) FROM TransactionMaster WHERE AccNo = AM.AccNo AND YEAR(DOO) = '2019') AS TxnCnt,
	(SELECT SUM(Amount) FROM TransactionMaster WHERE AccNo = AM.AccNo AND YEAR(DOO) = '2019') AS TotalAmount
FROM 
	AccountMaster AS AM
JOIN (
		SELECT
			AccNo,
			Count(*) AS Cnt
		FROM
			TransactionMaster
		WHERE
			YEAR(DOO) = '2019'
		GROUP BY
			AccNo
		HAVING
			Count(*) < 3 
	  ) AS DervTB
ON
	AM.AccNo = DervTB.AccNo
	

--CUBE Operator
SELECT	
	BranchID,
	ProductID,
	SUM(Balance) AS TotalBalance
FROM
	AccountMaster
GROUP BY
	BranchID,
	ProductID WITH CUBE

--ROLLUP Operator
SELECT	
	BranchID,
	ProductID,
	SUM(Balance) AS TotalBalance
FROM
	AccountMaster
GROUP BY
	BranchID,
	ProductID WITH ROLLUP

--Get 5th highest balance from Accountmaster
SELECT
	AccNo,
	Balance
FROM
	(
		SELECT
			AccNo,
			Balance,
			ROW_NUMBER() OVER (ORDER BY Balance DESC) AS Sr_No
		FROM
			AccountMaster
	) AS DervTb
WHERE
	Sr_No = 5

--List top 10 lowest balance in Descending order
SELECT
	AccNo,
	Balance
FROM
	(
		SELECT
			AccNo,
			Balance,
			ROW_NUMBER() OVER (ORDER BY Balance ASC) As Sr_No
		FROM
			AccountMaster
	) AS DrevTB
WHERE
	Sr_No < 11

	
	
	