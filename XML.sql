USE Practice_DB

--FOR XML PATH - Convert tabular data to JSON Format
SELECT 
	* 
FROM 
	accountmaster 
FOR XML PATH

--FOR XML AUTO - Convert tabular data to JSON Format
SELECT 
	* 
FROM 
	accountmaster 
FOR XML AUTO

--FOR XML AUTO + ELEMENTS- Convert tabular data to JSON Format
SELECT 
	* 
FROM 
	accountmaster 
FOR XML AUTO, ELEMENTS

--FOR XML AUTO + ELEMENTS + ROOT ELEMENT Convert tabular data to JSON Format
SELECT 
	* 
FROM 
	accountmaster AS Account
FOR XML AUTO, ELEMENTS, ROOT('Accounts')

SELECT 
	*
FROM 
	accountmaster
FOR XML PATH('Account'), ROOT('Accounts')

/* OUTPUT
<Accounts>
  <Account AccNo="60">
    <Name>Nikhil Jagnade</Name>
    <BranchID>BR1</BranchID>
    <Balance>7000</Balance>
    <ProductID>CA</ProductID>
    <DOO>1992-01-21</DOO>
    <Status>O</Status>
  </Account>
</Accounts>
*/
SELECT 
	AccNo AS "@AccNo",
	Name,
	BranchID,
	Balance,
	ProductID,
	DOO,
	Status
FROM 
	accountmaster
FOR XML PATH('Account'), ROOT('Accounts')

/* OUTPUT
<Accounts>
  <Account AccNo="60" Name="Nikhil Jagnade" BranchID="BR1" Balance="7000" ProductID="CA" DOO="1992-01-21" Status="O" />
</Accounts>
*/
SELECT 
	AccNo AS "@AccNo",
	Name AS "@Name",
	BranchID AS "@BranchID",
	Balance AS "@Balance",
	ProductID AS "@ProductID",
	DOO AS "@DOO",
	Status AS "@Status"
FROM 
	accountmaster
FOR XML PATH('Account'), ROOT('Accounts')

/*OUTPUT
<Persons>
  <Person ID="1">
    <Name>
      <FirstName>Nikhil</FirstName>
    </Name>
  </Person>
  <Person ID="2">
    <Name>
      <MiddleName>Pralhad</MiddleName>
    </Name>
  </Person>
  <Person ID="3">
    <Name>
      <LastName>Jagnade</LastName>
    </Name>
  </Person>
</Persons>
*/
SELECT 
	ID AS "@ID",
	First_Name AS "Name/FirstName",
	Middle_Name AS "Name/MiddleName",
	Last_Name AS "Name/LastName"
FROM 
	NameTB
FOR XML PATH('Person'), ROOT('Persons')

--Convert XML Data in Array Structure or Hierarchial structure
--INCLUDE_NULL_VALUES - Include null values also
SELECT 
	ID,
	First_Name AS "Name.FirstName",
	Middle_Name AS "Name.MiddleName",
	Last_Name AS "Name.LastName"
FROM 
	NameTB
FOR XML PATH

--ROOT("EntityName")
SELECT 
	ID,
	First_Name AS "Name.FirstName",
	Middle_Name AS "Name.MiddleName",
	Last_Name AS "name.LastName"
FROM 
	NameTB
FOR XML PATH, ROOT('Person')


--OPENXML() - XML TO SQL Tabular Data Conversion
DECLARE @idoc1 INT
DECLARE @XMLData1 NVARCHAR(MAX) = '
<Accounts>
  <Account>
    <AccNo>60</AccNo>
    <Name>Nikhil Jagnade</Name>
    <BranchID>BR1</BranchID>
    <Balance>7000</Balance>
    <ProductID>CA</ProductID>
    <DOO>1992-01-21</DOO>
    <Status>O</Status>
  </Account>
  <Account>
    <AccNo>61</AccNo>
    <Name>Praful J</Name>
    <BranchID>BR1</BranchID>
    <Balance>8000</Balance>
    <ProductID>SA</ProductID>
    <DOO>1992-02-21</DOO>
    <Status>O</Status>
  </Account>
  <Account>
    <AccNo>62</AccNo>
    <Name>Harshal J</Name>
    <BranchID>BR1</BranchID>
    <Balance>9000</Balance>
    <ProductID>FA</ProductID>
    <DOO>1992-03-21</DOO>
    <Status>O</Status>
  </Account>
</Accounts>
'
--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @idoc1 OUTPUT, @XMLData1;

-- Execute a SELECT statement that uses the OPENXML rowset provider.
SELECT *
FROM OPENXML(@idoc1, 'Accountmaster', 1) WITH (
        AccNo INT,
		Name VARCHAR(20),
		BranchID VARCHAR(10),
		Balance MONEY,
		ProductID VARCHAR(2),
		DOO Date,
		Status VARCHAR(1)
    );


/* XML Example 2 using Stored Procedure */
DECLARE @idoc INT, @doc VARCHAR(1000);

SET @doc = '
<ROOT>
<Customer CustomerID="VINET" ContactName="Paul Henriot">
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>
   </Order>
</Customer>
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>
   </Order>
</Customer>
</ROOT>';

--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;

-- Execute a SELECT statement that uses the OPENXML rowset provider.
SELECT *
FROM OPENXML(@idoc, '/ROOT/Customer', 1) WITH (
        CustomerID VARCHAR(10),
        ContactName VARCHAR(20)
    );


/* XML Example 3 */
--SET Tabular data in XML Format
DECLARE @AccXMLData XML = (SELECT * 
							FROM AccountMaster AS Account
							FOR XML AUTO, ELEMENTS, ROOT('Accounts'))
--Retrive all records
SELECT 
	AccNo = item.row.value('AccNo[1]', 'INT'),
	Name = item.row.value('Name[1]', 'VARCHAR(50)'),
	BranchID = item.row.value('BranchID[1]', 'VARCHAR(10)'),
	Balance = item.row.value('Balance[1]', 'MONEY'),
	ProductID = item.row.value('ProductID[1]', 'VARCHAR(2)'),
	DOO = item.row.value('DOO[1]', 'Date'),
	Status = item.row.value('Status[1]', 'VARCHAR(1)')
FROM 
	@AccXMLData.nodes('Accounts/Account') item(row)

