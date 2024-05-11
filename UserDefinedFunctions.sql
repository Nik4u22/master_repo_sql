USE Practice_DB

/* USER DEFINED FUNCTIONS
Three types - 1. Scalar Functn, 2. Inline table-valued Functn, 3. Multi statement table-valued Functn

SCALAR FUNCTION - Returns a scalar value
Scalar function may or may not have parameters, but always returns a single value. The return value can be of any datatype, except text, ntext, image, cursor & timestamp
Function Call - SELECT dbo.functnname

INLINE TABLE VALUED FUNCTION - Return a table
1. Specify TABLE as the return type instead of scalar value
2. The function body is not enclosed betweeb BEGIN and END block
3. The structure of table that gets returned, is determined by the SELECT statement with in the function
Function Call - SELECT * FROM db.functnname
*/

--SCALAR FUNCTION - fngetbalance
CREATE FUNCTION fnGetBalance(@AccNo INT)
RETURNS INT
AS
BEGIN

	DECLARE @BALANCE INT
	SELECT @BALANCE = Balance FROM AccountMaster WHERE AccNo = @AccNo

RETURN @BALANCE
END

--Call a function
SELECT dbo.fnGetbalance(62)

--Function text
sp_helptext fnGetbalance

--Function to return Age
CREATE FUNCTION Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
 RETURN @Age  
END

SELECT dbo.Age('21 Jan 1992')


/*
INLINE TABLE VALUED FUNCTION - Return a table and can be used in replacement of parametrized VIEWS
1. Specify TABLE as the return type instead of scalar value
2. The function body is not enclosed betweeb BEGIN and END block
3. The structure of table that gets returned, is determined by the SELECT statement with in the function
4. Table returned by INLINE TABLE VALED FUNCTION can also be used in joins with other tables.
5. Can update the data in returned table
Function Call - SELECT * FROM db.functnname or SELECT * FROM db.functnname WHERE Condtn

*/

--INLINE TABLE VALUED FUNCTION
CREATE FUNCTION fnGetAccDetails(@Balance INT)
RETURNS TABLE
AS
RETURN (SELECT * 
		FROM AccountMaster 
		WHERE Balance > @Balance)

--Function Call
SELECT * FROM dbo.fnGetAccDetails(3000)

SELECT * FROM dbo.fnGetAccDetails(3000) WHERE BranchID = 'BR1'

--Join tabled function with other table
SELECT A.Name AS CustName, B.Name AS City
FROM dbo.fnGetAccDetails(3000) AS A
JOIN Branch AS B
ON A.BranchID = B.BranchID

--Update data - Update in INLINE TABLE VALUED FUNCTION and Origional Table also
UPDATE dbo.fnGetAccDetails(3000) 
SET Name = 'Nikhil Jagnade'
WHERE AccNo = 60

SELECT * FROM dbo.fnGetAccDetails(3000)
SELECT * FROM AccountMaster

--Function text
sp_helptext fnGetAccDetails

/*
MULTI STATEMENT TABLE VALUED FUNCTION - Return a table with structure of the table
1. Specify TABLE + STRUCTURE as the return type instead of scalar value
2. The function body is enclosed betweeb BEGIN and END block
3. The structure of table that gets returned, is determined by the SELECT, INSERT statement with in the function
4. Table returned by INLINE TABLE VALED FUNCTION can also be used in joins with other tables.
5. Does not allow to update data in returned table
Function Call - SELECT * FROM db.functnname or SELECT * FROM db.functnname WHERE Condtn
*/

--MULTI STATEMENT TABLE VALUED FUNCTION
CREATE FUNCTION fnGetAccDetails2(@Balance INT)
RETURNS @Table TABLE(AccNo INT, Name VARCHAR(50))
AS
BEGIN
	
	INSERT INTO @Table
	SELECT AccNo, Name  
		FROM AccountMaster
		WHERE Balance > @Balance

	RETURN

END

--Function Call
SELECT * FROM dbo.fnGetAccDetails2(3000)

SELECT * FROM dbo.fnGetAccDetails2(3000) WHERE Name LIKE 'N%'

--Join tabled function with other table
SELECT A.Name AS CustName, B.Amount AS TxnAmount
FROM dbo.fnGetAccDetails2(3000) AS A
JOIN TransactionMaster AS B
ON A.AccNo = B.AccNo

--Could not Update data - Update in INLINE TABLE VALUED FUNCTION and Origional Table also
UPDATE dbo.fnGetAccDetails2(3000) 
SET Name = 'Nikhil Jagnade'
WHERE AccNo = 60 --Error: Object 'dbo.fnGetAccDetails2' cannot be modified.

--Function text
sp_helptext fnGetAccDetails2


CREATE FUNCTION fnComputeAge(@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN

	DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT
	SELECT @tempdate = @DOB

	SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END
	SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

	SELECT @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - CASE WHEN DAY(@DOB) > DAY(GETDATE()) THEN 1 ELSE 0 END
	SELECT @tempdate = DATEADD(MONTH, @months, @tempdate)

	SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

	DECLARE @Age NVARCHAR(50)
	SET @Age = Cast(@years AS  NVARCHAR(4)) + ' Years ' + Cast(@months AS  NVARCHAR(2))+ ' Months ' +  Cast(@days AS  NVARCHAR(2))+ ' Days Old'
	RETURN @Age

End

SELECT dbo.fnComputeAge('21 September 1992')