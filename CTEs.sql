USE Practice_DB

SELECT * FROM Branch

--DELETE duplicate records from branch table
SELECT * FROM DuplicateTB1

--Check duplicate records
SELECT
	Name,
	Count(*) AS Cnt
FROM
	DuplicateTB1
GROUP BY
	Name
HAVING
	Count(*) > 1

--Delete with CTE
WITH DuplicateTBCTE AS
(
	SELECT 
		*, 
		ROW_NUMBER() OVER (PARTITION BY Name ORDER BY Name) As Cnt
	FROM
		DuplicateTB1
)
DELETE
FROM
	DuplicateTBCTE
WHERE
	Cnt > 1

--Remove duplicate records from Branch Table
--Check duplicates in Branch Table
SELECT 
	BranchID, 
	Name, 
	Count(*) AS Cnt
FROM 
	Branch
GROUP BY 
	BranchID, 
	Name
Having 
	Count(*) > 1

--Remove duplicates using CTEs
WITH BranchCTE AS
(   -- Both PARTITION BY & ORDER BY is necessary
	SELECT 
		*, 
		ROW_NUMBER() OVER (PARTITION BY BranchID ORDER BY Name) AS RowCnt
	FROM 
		Branch
)

DELETE 
FROM 
	BranchCTE
WHERE 
	RowCnt > 1

--Check duplicates in Transaction Table
WITH TxnCTE AS
(
	SELECT 
		AccNo, 
		TxnID, 
		ROW_NUMBER() OVER (PARTITION BY AccNo ORDER BY TxnID) AS RowCnt
	FROM 
		TransactionMaster
)
SELECT 
	* 
FROM 
	TxnCTE
WHERE 
	RowCnt > 1

--List account holder having highest no of transactions
--Find no of transactions per account
SELECT 
	AccNo, 
	COUNT(AccNo) AS TxnCnt
FROM 
	TransactionMaster
GROUP BY 
	AccNo

--Using CTE list account holder having highest no of transactions
WITH AccMasterCTE AS
(
	SELECT
		AccNO,
		COUNT(*) AS Cnt
	FROM
		TransactionMaster
	GROUP BY
		AccNo
)

SELECT 
	AccNo,
	Cnt
FROM
	AccMasterCTE
WHERE
	Cnt = (
			SELECT
				MAX(Cnt)
			FROM
				AccMasterCTE
	)

--Find the name of accountholders and no of transactions using Join
SELECT 
	A.AccNo, 
	A.Name, 
	Count(T.AccNo) AS TxnCnt
FROM 
	AccountMaster A
JOIN 
	TransactionMaster T
ON 
	A.AccNo = T.AccNo
GROUP BY 
	A.AccNo, A.Name

--Find Name of account holders having sum of all transaction value greater than 1000
SELECT 
	A.Name, 
	T.Amount
FROM 
	AccountMaster As A
JOIN 
	TransactionMaster AS T
ON 
	A.AccNo = T.AccNo
WHERE 
	T.Amount > 1000

--WITH CTEs
WITH AccTxnCTE AS
(
	SELECT
		AccNo,
		SUM(Amount) AS TotalAmount
	FROM
		TransactionMaster
	GROUP BY
		AccNo
	HAVING 
		SUM(Amount) > 10000
)
SELECT 
	* 
FROM 
	AccTxnCTE

--Find Name of account holders having transaction value greater than 1000 and more than 1 transaction
SELECT 
	A.Name, 
	T.Amount, 
	COUNT(T.AccNo) AS TxnCnt
FROM 
	AccountMaster A
JOIN 
	TransactionMaster T
ON 
	A.AccNo = T.AccNo
WHERE 
	T.Amount > 1500
GROUP BY 
	A.Name, T.Amount
HAVING 
	COUNT(T.AccNo) > 1

--CTE With Parameters + JOIN
WITH AccountsCntCTE (BranchID, TotalAccounts) AS
(
	SELECT
		BranchID,
		COUNT(*) AS TotalAccounts
	FROM
		AccountMaster
	GROUP BY
		BranchID
)
SELECT 
	B.BranchID, 
	B.Name AS Branch_Name,
	TotalAccounts
FROM
	Branch AS B
JOIN
	AccountsCntCTE AS A
ON
	B.BranchID = A.BranchID
ORDER BY
	BranchID

SELECT * FROM AccountMaster

--Creating multiple CTEs with single WITH Clause
WITH MumbaiAccountsCntCTE (BranchID, TotalAccounts) AS
(
	SELECT
		BranchID,
		COUNT(*) AS TotalAccounts
	FROM
		AccountMaster
	WHERE
		ProductID IN ('CA', 'SA')
	GROUP BY
		BranchID
),
SiahaAccountsCntCTE (BranchID, TotalAccounts) AS
(
	SELECT
		BranchID,
		COUNT(*) AS TotalAccounts
	FROM
		AccountMaster
	WHERE
		ProductID IN ('FD', 'RD')
	GROUP BY
		BranchID

)
SELECT * FROM MumbaiAccountsCntCTE
UNION
SELECT * FROM SiahaAccountsCntCTE

--CTE based on one table - Can update records
WITH TxnCTE AS
(
	SELECT 
		TxnID, AccNO, Amount
	FROM
		TransactionMaster
)
UPDATE 
	TxnCTE
SET
	Amount = 30
WHERE
	TxnID = 3

--CTE based on two table - Can not update records
WITH AccTxnCTE AS
(
	SELECT
		A.AccNo,
		A.Balance,
		T.TxnID,
		T.Amount
	FROM
		AccountMaster AS A
	JOIN
		TransactionMaster AS T
	ON
		A.AccNo = T.AccNo
)
UPDATE 
	AccTxnCTE
SET 
	Amount = 30
WHERE
	TxnID = 3 
	--TxnID = 3 AND Balance = 3000 (Condition depends on columns from both the tables will not update the records)

--RECURSIVE CTE - Tis is a CTE that reference itself, primarily when you want to query hierarchial data or graph
SELECT
	employee.Name AS Employee_Name,
	manager.Name AS Manager_Name
FROM
	Emp AS employee
JOIN
	Emp AS manager
ON 
	employee.Manager_ID = manager.ID

--With CTE get level
WITH EmployeeManagerCTE (Name, ID, Manager_ID, [Level]) AS
(
	SELECT 
		Name,
		ID,
		Manager_ID,
		1
	FROM
		Emp
	WHERE
		Manager_ID IS NULL
	
	UNION ALL

	SELECT 
		employee.Name,
		employee.ID,
		employee.Manager_ID,
		EmpCTE.[Level] + 1
	FROM 
		Emp AS employee
	JOIN
		EmployeeManagerCTE AS EmpCTE
	ON
		employee.Manager_ID = EmpCTE.ID

)
SELECT
	empCTE.Name AS Employee_Name,
	managerCTE.Name AS Manager_Name,
	empCTE.Level
FROM
	EmployeeManagerCTE AS empCTE
JOIN
	EmployeeManagerCTE AS managerCTE
ON 
	empCTE.Manager_ID = managerCTE.ID