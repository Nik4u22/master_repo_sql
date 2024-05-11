USE Practice_DB

SELECT 
	* 
FROM 
	AccountMaster

SELECT 
	* 
FROM 
	TransactionMaster

--Find Highest balance in account
SELECT 
	MAX(Balance) 
FROM 
	AccountMaster

--Second Highest balance
SELECT 
	MAX(balance) 
FROM 
	AccountMaster
WHERE 
	Balance < (SELECT MAX(Balance) FROM AccountMaster)

--Sort balance by product id in ascending order
SELECT
	ProductID,
	Balance
FROM
	AccountMaster
ORDER BY
	ProductID ASC,
	Balance DESC

--Find highest balance by ProductID - each product id
SELECT 
	ProductID, 
	MAX(Balance)
FROM 
	AccountMaster
GROUP BY 
	ProductID

--Find highest balance by ProductID - each product id using Dense_Rank
SELECT
	ProductID, 
	Balance
FROM
	(SELECT 
		ProductID, 
		Balance,
		DENSE_RANK() OVER (PARTITION BY ProductID ORDER BY Balance DESC) AS ranking 
	FROM 
		AccountMaster) AS DevTb
WHERE
	ranking = 1

--Find Second Highest Balance by ProductID
SELECT 
	A1.ProductID, 
	MAX(A1.Balance)
FROM 
	AccountMaster AS A1
WHERE 
	A1.Balance < (SELECT MAX(A2.Balance)
					FROM AccountMaster A2
					WHERE A2.ProductID = A1.ProductID)
GROUP BY A1.ProductID

--Find Second highest balance by ProductID - each product id using Dense_Rank
SELECT
	ProductID,
	Balance
FROM
	(SELECT
		ProductID,
		Balance,
		DENSE_RANK() OVER (PARTITION BY ProductID ORDER BY Balance DESC) AS ranking
	FROM
		AccountMaster) AS DevTb
WHERE ranking = 2

--Rank Balance in Descending order
SELECT
	Name,
	Balance,
	DENSE_RANK() OVER ( ORDER BY Balance DESC) AS ranking
FROM
	AccountMaster
ORDER BY
	Balance DESC

--Create Stored Procedure to getBalance by rank
ALTER PROCEDURE spGetAccDetailsByBalanceRank(
	@rank INT
)
AS
BEGIN
	DECLARE @Cust_Name VARCHAR(100)
	DECLARE @Balance Money

	SELECT
		@Cust_Name = Name,
		@Balance = Balance
	FROM 
		(SELECT 
			Name,
			Balance,
			DENSE_RANK() OVER (ORDER BY Balance DESC) AS ranking
		FROM
			AccountMaster) AS DevTB
	WHERE 
		ranking = @rank

	--PRINT "Name"+SPACE(10)+"Balance"
	--PRINT @Cust_Name+SPACE(10)+@Balance
	PRINT 'Cust_Name:'+@Cust_Name
	PRINT 'Balance:'+CAST (@Balance AS VARCHAR)
END
GO

EXEC spGetAccDetailsByBalanceRank 1

--Find person having highest balance in account
SELECT 
	Name, 
	Balance 
FROM 
	AccountMaster
WHERE 
	Balance = (SELECT MAX(Balance) FROM AccountMaster)

--FInd person having second highest balance in account
SELECT 
	Name,
	Balance
FROM 
	AccountMaster
WHERE 
	Balance = (SELECT Max(Balance) FROM AccountMaster
					WHERE Balance < (SELECT Max(Balance) FROM AccountMaster))

--Find 5th Highest balance account holder in Accountmaster
SELECT 
	Name, 
	Balance 
FROM 
	AccountMaster
WHERE 
	Balance = (SELECT MIN(Balance)
					FROM AccountMaster
					WHERE Balance IN (SELECT TOP 5 Balance 
										FROM AccountMaster
										ORDER BY Balance DESC))

--Output crosscheck
EXEC spGetAccDetailsByBalanceRank 5

-- Find 10th highest balance account holder in AccountMaster
SELECT 
	Name, 
	Balance
FROM 
	AccountMaster
WHERE 
	Balance=(
				SELECT MIN(Balance) 
				FROM AccountMaster
				WHERE Balance IN (SELECT TOP 10 Balance 
									FROM AccountMaster 
									ORDER BY Balance DESC))

--Output crosscheck
EXEC spGetAccDetailsByBalanceRank 10

--Find 15th to 20th Highest Balance Account holders in AccountMaster
SELECT 
	TOP 5 Name, 
	Balance
FROM 
	AccountMaster
WHERE 
	Balance IN (
					SELECT TOP 5 Balance
					FROM AccountMaster
					WHERE Balance IN (
										SELECT TOP 20 Balance
										FROM AccountMaster 
										ORDER BY Balance DESC
					)
					ORDER BY Balance ASC
) 
ORDER BY Balance DESC 

--DELETE duplicate records using Subquery
SELECT 
	Name, 
	COUNT(*) AS Cnt
FROM 
	AccountMaster
GROUP BY 
	Name
HAVING 
	COUNT(*) > 1

--CORRELATED SUBQUERY [ Loop Within Loop ]
--Account Holder who has done transactions
SELECT AccNo, Name 
FROM AccountMaster AS AM 
WHERE EXISTS(
	SELECT TxnID 
	FROM TransactionMaster AS TM
	WHERE AM.AccNo = TM.AccNo
)

--Account Holders Who has not done transactions
--CORRELATED SUBQUERY
SELECT AccNo, Name
FROM AccountMaster AS AM
WHERE NOT EXISTS(
	SELECT TxnID
	FROM TransactionMaster AS TM
	WHERE AM.AccNo = TM.AccNo
)

SELECT * FROM AccountMaster
SELECT * FROM TransactionMaster

--Account holders who have done transaction this year with TxnCnt
--CORRELATED SUBQUERY
SELECT 
	AccNo,
	Name,
	(SELECT Count(*) AS Cnt FROM TransactionMaster WHERE AccNo = AM.AccNo AND DATEDIFF(YY, DOO, GETDATE()) = 0) AS CntTxn
FROM
	AccountMaster AS AM
WHERE 
	EXISTS (
		SELECT
			AccNo,
			Name
		FROM
			TransactionMaster AS TM
		WHERE 
			AM.AccNo = TM.AccNo AND
			DATEDIFF(YY, TM.DOO, GETDATE()) = 0)

--Cross check / cross validation
SELECT 
	* 
FROM 
	TransactionMaster 
WHERE 
	DATEDIFF(YY, DOO, GETDATE()) = 0

--Account holders who have done transaction in last two years year with TxnCnt
--CORRELATED SUBQUERY
SELECT 
	AccNo,
	Name,
	(SELECT Count(*) AS Cnt FROM TransactionMaster WHERE AccNo = AM.AccNo AND DATEDIFF(YY, DOO, GETDATE()) < 2) AS CntTxn
FROM
	AccountMaster AS AM
WHERE 
	EXISTS (
		SELECT
			AccNo,
			Name
		FROM
			TransactionMaster AS TM
		WHERE 
			AM.AccNo = TM.AccNo AND
			DATEDIFF(YY, TM.DOO, GETDATE()) < 2 )

--Cross check / cross validation
SELECT 
	* 
FROM 
	TransactionMaster 
WHERE 
	DATEDIFF(YY, DOO, GETDATE()) < 2

--Account holders who have done transaction in last five years year with TxnCnt
--CORRELATED SUBQUERY
SELECT 
	AccNo,
	Name,
	(SELECT Count(*) AS Cnt FROM TransactionMaster WHERE AccNo = AM.AccNo AND DATEDIFF(YY, DOO, GETDATE()) < 4) AS CntTxn
FROM
	AccountMaster AS AM
WHERE 
	EXISTS (
		SELECT
			AccNo,
			Name
		FROM
			TransactionMaster AS TM
		WHERE 
			AM.AccNo = TM.AccNo AND
			DATEDIFF(YY, TM.DOO, GETDATE()) < 4 )

--Cross check / cross validation
SELECT 
	* 
FROM 
	TransactionMaster 
WHERE 
	DATEDIFF(YY, DOO, GETDATE()) < 4

--List accountholders who have done more than 1 transaction in year 2021 with TxnCnt
--CORRELATED SUBQUERY
SELECT
	AccNo,
	Name,
	(SELECT Count(*) AS Cnt FROM TransactionMaster WHERE AccNo = AM.AccNo) AS CntTxn
FROM
	AccountMaster AS AM
WHERE
	EXISTS (
			SELECT
				AccNo,
				Count(*) AS Cnt
			FROM
				TransactionMaster AS TM
			WHERE 
				AM.AccNo = TM.AccNo AND
				YEAR(DOO) = '2021'
			GROUP BY
				AccNo
			HAVING
				Count(*) < 2)

--List accountholders who have done at max 2 transaction in year 2019 with TxnCnt and TotalAmount
--CORRELATED SUBQUERY
SELECT
	AccNo,
	Name,
	--(SELECT Type FROM TransactionMaster WHERE AccNo = AM.AccNo AND YEAR(DOO) = '2019') AS TxnType,
	(SELECT Count(*) FROM TransactionMaster WHERE AccNo = AM.AccNo AND YEAR(DOO) = '2019') AS TxnCnt,
	(SELECT SUM(Amount) FROM TransactionMaster WHERE AccNo = AM.AccNo AND YEAR(DOO) = '2019') AS TotalAmt
FROM
	AccountMaster AS AM
WHERE
	EXISTS (
			SELECT 
				AccNo,
				Count(*) AS Cnt
			FROM
				TransactionMaster AS TM
			WHERE
				AM.AccNo = TM.AccNo AND
				YEAR(DOO) = '2019'
			GROUP BY
				AccNO
			HAVING
				Count(*) < 3 )

--Cross check / cross validation
SELECT 
	* 
FROM 
	TransactionMaster 
WHERE 
	YEAR(DOO) = '2019'