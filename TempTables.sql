USE Practice_DB

--LOCAL TEMP TABLE - Can't access outside this connection
CREATE TABLE #LOCALTEMP_TB1(
ID INT,
Name VARCHAR(50)
)
INSERT INTO #LOCALTEMP_TB1 VALUES (1, 'Nik'), (2, 'Pan')

SELECT * FROM #LOCALTEMP_TB1

--LOCAL TEMP TABLE - Can't access outside this connection
CREATE TABLE #LOCALTEMP_TB2(
ID INT,
Name VARCHAR(50)
)
INSERT INTO #LOCALTEMP_TB2 VALUES (1, 'Vik'), (2, 'Har')

SELECT * FROM #LOCALTEMP_TB2

--GLOBAL TEMP TABLE - Can't access outside this connection
CREATE TABLE ##GLOBALTEMP_TB1(
ID INT,
Name VARCHAR(50)
)
INSERT INTO ##GLOBALTEMP_TB1 VALUES (1, 'Nik'), (2, 'Pan')

SELECT * FROM ##GLOBALTEMP_TB1

--TEMP TABLE inside STORED PROCEDURE
--TEMP TABLE gets created inside the sp and deleted automatically, we can't access it outside

CREATE PROCEDURE spCreateTempTable
AS
BEGIN
	CREATE TABLE #LOCALTEMP_TB3(
	ID INT,
	Name VARCHAR(50)
	)
	INSERT INTO #LOCALTEMP_TB3 VALUES (1, 'Nik'), (2, 'Pan')

	SELECT * FROM #LOCALTEMP_TB3
END

EXECUTE spCreateTempTable