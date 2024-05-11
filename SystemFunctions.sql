/* DATE & TIME FUNCTIONS
UTC - Cordinated Universal Time
GMT - Greenwich Mean Time

DATATYPES
Time - 3 to 4 bytes
Date - 4 bytes
DateTime - 8 Bytes
*/

USE Practice_DB

--GETDATE(), GETUTCDATE(), SYSDATETIME(), SYSUTCDATETIME() - Returns current date

SELECT GETDATE()--Date + Time

SELECT GETUTCDATE()--Date+Time

SELECT SYSDATETIME()--Date+Time

SELECT SYSUTCDATETIME()--Date+time

--Create datekey using currentdate
SELECT YEAR(GETDATE())*10000 + MONTH(GETDATE())*100 + DAY(GETDATE()) AS DateKey

--YEAR(), MONTH(), YEAR()

--YEAR() - Return the year number of the given date
SELECT YEAR(GETDATE())--2023

--MONTH() - Return month number of the given date in the current year
SELECT MONTH(GETDATE())--8

--DAY() - Return day number of the given date in the month
SELECT DAY(GETDATE())--6

--DATEDIFF() - Retruns difference between two dates in Intervals like DAY, MONTH, YEAR

SELECT DATEDIFF(YY, '21 Jan 1992', GETDATE()) AS AgeInYears -- 31 [Years]

SELECT DATEDIFF(MM, '21 jan 1992', GETDATE()) AS AgeInMonths --379 [Months]

SELECT DATEDIFF(DD, '21 Jan 1992', GETDATE()) AS AgeInDays --11520 [Days]

SELECT DATEDIFF(DD, GETDATE(), '18 September 2023')

SELECT DATEDIFF(DD, GETDATE(), '25 Oct 2023')

--DATENAME()--Returns date in name format like YY, MM, DW

SELECT DATENAME(YY, GETDATE()) --2023

SELECT DATENAME(MM, GETDATE())--August

SELECT DATENAME(DD, GETDATE())--6

SELECT DATENAME(DW, GETDATE())--Sunday

SELECT DATENAME(WEEKDAY, GETDATE())--Sunday

SELECT DATENAME(DY, GETDATE())--218

--DATEPART()--Returns part of the date in Intervals like YEAR, MONTH, DAY

SELECT DATEPART(YEAR, GETDATE())--2023

SELECT DATEPART(MONTH, GETDATE())--8

SELECT DATEPART(DAY, GETDATE())--6

--IDDATE()-Checks if the given value is valid date, time or datetime. Return 1 if true else 0

SELECT ISDATE('12-01-2020')--1

SELECT ISDATE('Nik')--0

SELECT ISDATE(GETDATE())--1

--DATEADD()- Returns the DateTime after adding specified numbers to add

SELECT DATEADD(DAY, 10, GETDATE())--+10 days
SELECT DATEADD(DAY, -10, GETDATE())-- -10 days

SELECT DATEADD(MONTH, 5, GETDATE())--+ 5 Months

SELECT DATEADD(YEAR, 2, GETDATE())--+ 2 Years


/* STRING FUNCTIONS */
/*
ASCII - Returns ASCII code of the given character expression
ASCII (Char/Varchar expression) RETURN - Integer Value
*/

SELECT ASCII('A') --65
SELECT ASCII('ABC') --65 retuns ASCII value for only first character

/*
CHAR(Integer expression) RETURN - Character 
*/
SELECT CHAR(66) --B

--Print Alphabets from A-Z
DECLARE @Start INT
SET @Start = 65
WHILE(@Start <= 90)
BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start + 1
END

SELECT ASCII('a') --97

--Print Alphabets from a-z
DECLARE @Start INT
SET @Start = 97
WHILE(@Start <= 122)
BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start + 1
END

SELECT ASCII('0')
--Print Numbers from 0-9
DECLARE @Start INT
SET @Start = 48
WHILE(@Start <= 57)
BEGIN
	PRINT CHAR(@Start)
	SET @Start = @Start + 1
END

/*
LTRIM(Character expression) - Remove blanks from the left hand side of the character expression
RTRIM(Character expression) - Remove blanks from the right hand side of the character expression
*/

SELECT LTRIM('   Nikhil')

SELECT RTRIM('Nikhil      ')

SELECT LTRIM(RTRIM('   Nikhil    '))
/*
LOWER(Character expression) - Convert all the characters in the given character expression to a lowercase letter
UPPER(Character expression) - Convert all the characters in the given character expression to a uppercase letter
*/

SELECT LOWER('Nikhil jagnade')

SELECT UPPER('Nikhil Jagnade')

/*
REVERSE(String expression) - Reverse all the characters in the given string expression
*/

SELECT REVERSE(UPPER(LTRIM(RTRIM('    Nikhil    '))))

/*
LEN(String expression) - Return all the count of total characters in the given string expression
* Exclude the blanks at the end of an expression but does not exclude balnks at the start of an expression
*/

SELECT LEN('  Nikhil  ') --8 (excluded the blanks at the end of an expression)
SELECT LEN('  Nikhil') --8
SELECT LEN('Nikhil  ') --6 (excluded the blanks at the end of an expression)
SELECT LEN(LTRIM('  Nikhil'))--6 9Removed blanks at the start of an expression using LTRIM()

/*
LEFT(Character expression, Integer expression) - Return the specified no of given characters from the left hand side of the given character expression
RIGHT(Character expression, Integer expression) - Return the specified no of given characters from the right hand side of the given character expression
*/

SELECT LEFT('NIKHIL JAGNADE', 3)--NIK
SELECT RIGHT('NIKHIL JAGNADE', 4)--NADE

/*
CHARINDEX('Expression to find', 'Expression to search', start location-optional) - Return the index of the starting position of the specified expressionin a character string
*/

SELECT CHARINDEX('@', 'nikhiljagnade22@gmail.com')--16
SELECT CHARINDEX('@', 'nikhiljagnade22@gmail.com', 5)--16
SELECT CHARINDEX('@', 'nikhiljagnade22@gmail.com', 50)--0

/*
SUBSTRING('Expression', start, end) - Returns substring from the given expression
*/

SELECT SUBSTRING('abc@gmail.com', 10, 13)--com
SELECT SUBSTRING('abc@gmail.com', LEN('abc@gmail.com') - 3, LEN('abc@gmail.com')) --.com
SELECT SUBSTRING('abc@gmail.com', CHARINDEX('@', 'abc@gmail.com')+1, LEN('abc@gmail.com')) AS Domain_Name 

DROP TABLE IF EXISTS Emp3
CREATE TABLE Emp3(
ID INT IDENTITY(1,1) NOT NULL,
Email VARCHAR(50)
)
INSERT INTO Emp3 VALUES('abc@gmail.com'), ('pqr@yahoo.com'), ('xyz@google.co.in'), ('lmn@orcut.com'), ('nik@gmail.com') 

--Count of employee domain wise
SELECT SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email)) AS Domain_Name, COUNT(*) AS EmpCnt
FROM Emp3
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email))

/*
REPLICATE(String to be replicated, no of times) - Repeats the given string for the specified no of times
*/

SELECT REPLICATE('Nik', 4)--Nik Nik Nik Nik

SELECT ID, SUBSTRING(Email, 1,2) + REPLICATE('*', 5) + SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email)) AS Email
FROM Emp3

/*
SPACE(No of spaces) - Return the no of spaces
*/

SELECT SPACE(5)+'Nik'

SELECT SPACE(5)+Email 
FROM Emp3

/*
PATINDEX('%pattern%', expression) - Return the starting position of the first occurance of pattern in a given expression
*/

SELECT Email, PATINDEX('%@%', Email) AS PATINDEX
FROM Emp3

SELECT Email, PATINDEX('%@g%', Email) AS PATINDEX
FROM Emp3

/*
REPLACE(String_Expression, Pattern, Replacement_Value) - Replace all occurance of a specified string value with another string value
*/

SELECT Email, REPLACE(Email, '.com', '.in') AS Converted_Email
FROM Emp3

/*
STUFF(Origional_Expression, Start, Length, Replacement_Expression) - Inserts replacement expression at the start position specified along with removing
	the characters specified using Length parmater
*/

SELECT Email, STUFF(Email, 2, 3, '*********') AS Stuffed_Email
FROM Emp3

/*
CONCAT() - use to concatenate two or more string values
*/
SELECT CONCAT('Nikhil', 'Jagnade')

SELECT CONCAT('Nikhil', 'Jagnade', 'Hi')

SELECT CONCAT('Hi', 'I', 'am', 'going', 'to', 'school')

/* DATATYPE CONVERSION
CAST() - Based on ASCII Standards

CONVERT() - Specific to SQL server, It provide more flexibility than CAST() and support style functionality

**Use CAST() generally and if we want to get additional style functionality then use CONVERT()
*/

--CAST(source_column as datatype)
SELECT *, CAST(TxnDate AS VARCHAR(50)) AS Converted_TxnDate
FROM Sales

SELECT CAST(GETDATE() AS Date)
SELECT CAST(GETDATE() AS Time)

--CONVERT(datatype, source_column, style_parameter - optional)
SELECT *, CONVERT(VARCHAR(50), TxnDate) AS Converted_TxnDate
FROM Sales

--style - 101, 102, 103, 104, 105
SELECT *, CONVERT(VARCHAR(50), TxnDate, 103) AS Converted_TxnDate
FROM Sales

/* MATHEMATICAL FUNCTIONS*/

--ABS() - Returns absolute value
SELECT ABS(-109.7)

--RAND(seed_value) - Returns a random float number between 0 & 1
SELECT RAND() -- Always return different number
SELECT RAND(100) --Always return same number
SELECT (RAND() * 100)
SELECT FLOOR(RAND() * 100)

--CEILING() - Returns smallest integer value greater than or equal to parameter
SELECT CEILING(7.6)--8
SELECT CEILING(7.3)--8
SELECT CEILING(-7.3)-- -7

--FLOOR() - Returns largest integer value greater than or equal to parameter
SELECT FLOOR(7.6)--7
SELECT FLOOR(7.3)--7
SELECT FLOOR(-7.3)-- -8

SELECT POWER(2, 2)--4
SELECT SQUARE(10)--100
SELECT SQRT(100)--10

--ROUND(numeric_exp, length[ functn]) - Rounds the given numeric expression based on the given length
SELECT ROUND(107.56, 1)-- 107.60
SELECT ROUND(107.56, 1, 1)-- 107.50
SELECT ROUND(107.56, 2)-- 107.56

