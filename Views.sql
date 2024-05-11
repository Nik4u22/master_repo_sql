USE Practice_DB

/* VIEW

View is a virtual table just store the select query not data by deafult and excute stored query whenever call.
Whenever INSERT, UPDATE or DELETE operations perform with the help of view in underlying base table data only changes.
*/
--Create View
CREATE VIEW AccTxnView 
AS
SELECT A.AccNo, A.Name AS [Customer Name], B.BranchID, B.Name AS [City]
FROM AccountMaster A
JOIN Branch B
ON A.BranchID = B.BranchID

--Select View
SELECT * FROM AccTxnView

SELECT 
	*
FROM
	AccTxnView
WHERE Balance = (SELECT 
					MAX(Balance) 
				 FROM
					AccTxnView)

--To view AccTxnView text
sp_helptext AccTxnView

--CREATE OR ALTER VIEW
CREATE OR ALTER VIEW AccTxnView
AS
SELECT A.AccNo, A.Name AS [Customer Name], B.BranchID, B.Name AS [City]
FROM AccountMaster A
JOIN Branch B
ON A.BranchID = B.BranchID
WHERE B.BranchID = 'BR7'

--INSERT data in View
--Error: View or function 'AccTxnView' is not updatable because the modification affects multiple base tables.
INSERT INTO AccTxnView VALUES (87, 'Ajay Khanna', 'BR4', 'Siaha'),
							  (88, 'Vinay Shah', 'BR2', 'Nagpur')

--DELETE FROM VIEW
--Error: View or function 'AccTxnView' is not updatable because the modification affects multiple base tables.
DELETE FROM AccTxnView
WHERE [Customer Name] = 'Akshy K'


SELECT * FROM AccTxnView

--Drop View
DROP VIEW IF EXISTS AccTxnView
DROP VIEW AccTxnView


CREATE VIEW AccTxnView AS
SELECT * FROM AccountMaster

SELECT * FROM AccTxnView
SELECT * FROM AccountMaster

--Insert Successsfull -- Insert data to both view and table simultaneously
INSERT INTO AccTxnView VALUES ('Pranay mangulkar', 'BR10', 9099, 'FD', '21 Jan 1996', 'O')

--Delete Successfull - Delete data from both view and table simultaneously
DELETE FROM AccTxnView
WHERE AccNo = 102

--We can't create VIEW on the TEMP TABLES
--LOCAL TEMP TABLE - Can't access outside this connection
CREATE TABLE #LOCALTEMP_TB1(
ID INT,
Name VARCHAR(50)
)
INSERT INTO #LOCALTEMP_TB1 VALUES (1, 'Nik'), (2, 'Pan')

--Create View on temp tables
--Error: Views or functions are not allowed on temporary tables. Table names that begin with '#' denote temporary tables.
CREATE VIEW vwTempTable
AS
SELECT * 
FROM #LOCALTEMP_TB1