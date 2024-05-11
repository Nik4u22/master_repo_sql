USE Practice_DB

/*
A Stored Procedure is a group of T-SQL Statements - Code reusuability
*/
--CREATE SP
CREATE PROCEDURE spGetAccountDetails
AS
BEGIN
	SELECT * FROM AccountMaster
END

--Call SP
spGetAccountDetails -- Select & click on execute
EXEC spGetAccountDetails
EXECUTE spGetAccountDetails

--Crate SP with parameters / PROC or PROCEDURE
CREATE PROC spGetAccDetailsByBranchAndBalance
@BranchID VARCHAR(20),
@Balance NUMERIC
AS
BEGIN
	SELECT Name, BranchID, Balance 
	FROM AccountMaster
	WHERE BranchID = @BranchID AND Balance > @Balance
END

--Call SP
EXEC spGetAccDetailsByBranchAndBalance 'BR1', 8000
EXEC spGetAccDetailsByBranchAndBalance @BranchID = 'BR1', @Balance = 8000
EXEC spGetAccDetailsByBranchAndBalance 8000, 'BR1' --Error converting data type varchar to numeric. / Converted 8000 to varchar but could not convert BR1 to numeric
EXEC spGetAccDetailsByBranchAndBalance @Balance = 8000, @BranchID = 'BR1'

/*
Do not prefix SP with sp_spname as these are system defined SP
*/
--Get schema of SP using sp_helptext
sp_helptext spGetAccountDetails
sp_helptext spGetAccDetailsByBranchAndBalance

--Alter SP
ALTER PROCEDURE spGetAccountDetails  
AS  
BEGIN  
 SELECT * 
 FROM AccountMaster 
 ORDER BY Name   
END

EXEC spGetAccountDetails

--Drop SP
DROP PROC spGetAccountDetails

--Alter & Encrypt SP so via sp_helptext we can't view sp schema
EXEC spGetAccDetailsByBranchAndBalance @BranchID = 'BR1', @balance = 5000

sp_helptext spGetAccDetailsByBranchAndBalance -- It will work

--Alter SP with parameters & apply Encryption  
/*
Encryption - Once SP is encrypted we can't view the contect of the sp
*/
ALTER PROC spGetAccDetailsByBranchAndBalance  
@BranchID VARCHAR(20),  
@Balance NUMERIC  
WITH ENCRYPTION
AS  
BEGIN  
 SELECT Name, BranchID, Balance   
 FROM AccountMaster  
 WHERE BranchID = @BranchID AND Balance > @Balance  
END

/*
sp_help spName --Display definition of SP object
sp_helptext spName -- Display text of the SP object
sp_depends spName --Display dependability of SP on ther database objects like tables/views/function [We can't delete these objects until we drop SP]
*/

sp_help spGetAccDetailsByBranchAndBalance
sp_helptext spGetAccDetailsByBranchAndBalance -- It will work but message: The text for object 'spGetAccDetailsByBranchAndBalance' is encrypted.
sp_depends spGetAccDetailsByBranchAndBalance

--Create SP with OUT/OUTPUT Parameters
CREATE PROCEDURE spGetAccCountByBranch
@BranchID VARCHAR(20),
@AccountCnt INT OUTPUT
AS
BEGIN
	SELECT @AccountCnt = COUNT(AccNo) 
	FROM AccountMaster
	WHERE BranchID = @BranchID
END

--To call Sp execute these three statements at a time
DECLARE @AccountCnt INT
EXEC spGetAccCountByBranch @BranchID = 'BR1', @AccountCnt = @AccountCnt OUTPUT
PRINT @AccountCnt

DECLARE @AccountCnt INT
EXEC spGetAccCountByBranch @BranchID = 'BR1', @AccountCnt = @AccountCnt OUTPUT
IF(@AccountCnt IS NULL)
	PRINT '@AccountCnt is null'
ELSE
	PRINT '@AccountCnt is not null'

PRINT @AccountCnt

/*
If we don't specify the OUTPUT keyword then @AccountCnt variable will return NULL Value
*/
DECLARE @AccountCnt INT
EXEC spGetAccCountByBranch @BranchID = 'BR1', @AccountCnt = @AccountCnt --If we doesn't pass OUTPUT keyword then it will execute but will not display result
IF(@AccountCnt IS NULL)
	PRINT '@AccountCnt is null'
ELSE
	PRINT '@AccountCnt is not null'

PRINT @AccountCnt


/*
OUTPUT Parameters OR RETURN Values
Whenever, we execute a stored procedure, it return an integer status variable
usually, 0 indicate success & Non-Zero indicates failure

RETURN VALUE
1. return only value in INT datatype
2. return only one value
3. Use to convey success or failure of sp

OUTPUT Parameters
1. return value in any datatype
2. return multiple values
3. use to return values like name, cnt etc
*/

--SP with return keyword only --Only INT Value
CREATE PROCEDURE spGetAccountCnt
AS
BEGIN
	RETURN (SELECT COUNT(AccNo) FROM AccountMaster)
END

DECLARE @AccountCnt INT
EXEC @AccountCnt = spGetAccountCnt
PRINT @AccountCnt

--sp with return keyword will not return string value (Solution: Use OUTPUT parameter)
DROP PROCEDURE IF EXISTS spGetAccountName
CREATE PROCEDURE spGetAccountName
AS
BEGIN
	RETURN (SELECT Name FROM AccountMaster WHERE AccNo=65)
END

DECLARE @AccountName VARCHAR(50)
EXEC @AccountName = spGetAccountName --Error: Conversion failed when converting the varchar value 'Kalpna J' to data type int.
PRINT @AccountName

--Check all stored procedures & Functions created by user
SELECT * 
FROM sys.sql_modules

--By specific object_id
SELECT * 
FROM sys.sql_modules
WHERE object_id = '114099447'

SELECT OBJECT_NAME (OBJECT_ID) AS Object_Name, definition
FROM sys.sql_modules


--SP To GetData with optional parameters & Multipurpose
CREATE PROCEDURE sp_getAllAccounts
	@AccNo INT = NULL,
	@Name VARCHAR(20) = NULL,
	@BranchID VARCHAR(10) = NULL,
	@Balance MONEY = NULL,
	@ProductID VARCHAR(2) = NULL,
	@DOO Date = NULL,
	@Status VARCHAR(1) = NULL
AS
	SELECT 
		*
	FROM 
		accountmaster
	WHERE
		(@AccNo IS NULL OR AccNo = @AccNo) AND
		(@Name IS NULL OR Name LIKE @Name) AND
		(@BranchID IS NULL OR BranchID LIKE @BranchID) AND
		(@Balance IS NULL OR Balance = @Balance) AND
		(@ProductID IS NULL OR ProductID LIKE @ProductID) AND
		(@DOO IS NULL OR DOO = @DOO) AND
		(@Status IS NULL OR Status = @Status)

--Call sp_getAllAccounts
EXEC sp_getAllAccounts -- return all records
EXEC sp_getAllAccounts @AccNo = 60
EXEC sp_getAllAccounts @Name = 'Nik%'
EXEC sp_getAllAccounts @BranchID = '%1', @Name = 'Nik%'