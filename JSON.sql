USE Practice_DB

--FOR JSON PATH - Convert tabular data to JSON Format
SELECT * 
FROM AccountMaster 
FOR JSON PATH

--FOR JSON AUTO - Convert tabular data to JSON Format
SELECT * 
FROM AccountMaster 
FOR JSON AUTO

--Convert JSON Data in Array Structure or Hierarchial structure
--INCLUDE_NULL_VALUES - Include null values also
SELECT ID,
		First_Name AS "Name.FirstName",
		Middle_Name AS "Name.MiddleName",
		Last_Name AS "Name.LastName"
FROM NameTB
FOR JSON PATH, INCLUDE_NULL_VALUES

--ROOT("EntityName")
SELECT ID,
		First_Name AS "Name.FirstName",
		Middle_Name AS "Name.MiddleName",
		Last_Name AS "name.LastName"
FROM NameTB
FOR JSON PATH, ROOT('Person')

--WITHOUT_ARRAY_WRAPPER - Without Array Wrapper for JSONData
SELECT * 
FROM AccountMaster 
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER

--OPENJSON() - JSON TO SQL Tabular Data Conversion
DECLARE @JSON NVARCHAR(MAX) = '[{"AccNo":60,"Name":"Nikhil Jagnade","BranchID":"BR1","Balance":7000,"ProductID":"CA","DOO":"1992-01-21","Status":"O"},{"AccNo":61,"Name":"Praful J","BranchID":"BR1","Balance":8000,"ProductID":"SA","DOO":"1992-02-21","Status":"O"},{"AccNo":62,"Name":"Harshal J","BranchID":"BR1","Balance":9000,"ProductID":"FA","DOO":"1992-03-21","Status":"O"},{"AccNo":63,"Name":"Shraddha J","BranchID":"BR1","Balance":10000,"ProductID":"RD","DOO":"1992-04-21","Status":"O"},{"AccNo":64,"Name":"Ved J","BranchID":"BR1","Balance":11000,"ProductID":"LA","DOO":"1992-05-21","Status":"O"},{"AccNo":65,"Name":"Kalpna J","BranchID":"BR1","Balance":12000,"ProductID":"FD","DOO":"1992-06-21","Status":"D"},{"AccNo":66,"Name":"Rangrao W","BranchID":"BR2","Balance":7500,"ProductID":"CA","DOO":"1992-07-21","Status":"O"},{"AccNo":67,"Name":"Jyoti W","BranchID":"BR2","Balance":8500,"ProductID":"SA","DOO":"1992-08-21","Status":"O"},{"AccNo":69,"Name":"Pooja W","BranchID":"BR2","Balance":9500,"ProductID":"FA","DOO":"1992-09-21","Status":"O"},{"AccNo":70,"Name":"Bhushan W","BranchID":"BR2","Balance":10500,"ProductID":"RD","DOO":"1992-10-21","Status":"D"},{"AccNo":71,"Name":"Shrani W","BranchID":"BR2","Balance":11500,"ProductID":"LA","DOO":"1992-11-21","Status":"O"},{"AccNo":72,"Name":"Shyam W","BranchID":"BR2","Balance":12500,"ProductID":"FD","DOO":"1992-12-21","Status":"O"},{"AccNo":73,"Name":"Daulat R","BranchID":"BR3","Balance":7600,"ProductID":"CA","DOO":"1993-01-21","Status":"O"},{"AccNo":74,"Name":"Sheela R","BranchID":"BR3","Balance":8600,"ProductID":"SA","DOO":"1993-02-21","Status":"O"},{"AccNo":75,"Name":"Pankaj R","BranchID":"BR3","Balance":9600,"ProductID":"FA","DOO":"1993-03-21","Status":"O"},{"AccNo":76,"Name":"Ankita R","BranchID":"BR3","Balance":10600,"ProductID":"RD","DOO":"1993-04-21","Status":"D"},{"AccNo":77,"Name":"Sushant D","BranchID":"BR4","Balance":7700,"ProductID":"CA","DOO":"1993-05-21","Status":"O"},{"AccNo":78,"Name":"Shreyash D","BranchID":"BR4","Balance":8700,"ProductID":"SA","DOO":"1993-06-21","Status":"O"}]'

SELECT *
FROM OPENJSON(@JSON)
WITH(
	AccNo INT '$.AccNo',
	Name VARCHAR(50) '$.Name',
	BranchID VARCHAR(20) '$.BranchID',
	Balance MONEY '$.Balance',
	ProductID VARCHAR(20) '$.ProductID',
	DOO DATE '$.DOO',
	Status VARCHAR(2) '$.Status'
)

--JSON_VALUE()
DECLARE @JSON2 NVARCHAR(MAX) = '[{"AccNo":60,"Name":"Nikhil Jagnade","BranchID":"BR1","Balance":7000,"ProductID":"CA","DOO":"1992-01-21","Status":"O"},{"AccNo":61,"Name":"Praful J","BranchID":"BR1","Balance":8000,"ProductID":"SA","DOO":"1992-02-21","Status":"O"},{"AccNo":62,"Name":"Harshal J","BranchID":"BR1","Balance":9000,"ProductID":"FA","DOO":"1992-03-21","Status":"O"},{"AccNo":63,"Name":"Shraddha J","BranchID":"BR1","Balance":10000,"ProductID":"RD","DOO":"1992-04-21","Status":"O"},{"AccNo":64,"Name":"Ved J","BranchID":"BR1","Balance":11000,"ProductID":"LA","DOO":"1992-05-21","Status":"O"},{"AccNo":65,"Name":"Kalpna J","BranchID":"BR1","Balance":12000,"ProductID":"FD","DOO":"1992-06-21","Status":"D"},{"AccNo":66,"Name":"Rangrao W","BranchID":"BR2","Balance":7500,"ProductID":"CA","DOO":"1992-07-21","Status":"O"},{"AccNo":67,"Name":"Jyoti W","BranchID":"BR2","Balance":8500,"ProductID":"SA","DOO":"1992-08-21","Status":"O"},{"AccNo":69,"Name":"Pooja W","BranchID":"BR2","Balance":9500,"ProductID":"FA","DOO":"1992-09-21","Status":"O"},{"AccNo":70,"Name":"Bhushan W","BranchID":"BR2","Balance":10500,"ProductID":"RD","DOO":"1992-10-21","Status":"D"},{"AccNo":71,"Name":"Shrani W","BranchID":"BR2","Balance":11500,"ProductID":"LA","DOO":"1992-11-21","Status":"O"},{"AccNo":72,"Name":"Shyam W","BranchID":"BR2","Balance":12500,"ProductID":"FD","DOO":"1992-12-21","Status":"O"},{"AccNo":73,"Name":"Daulat R","BranchID":"BR3","Balance":7600,"ProductID":"CA","DOO":"1993-01-21","Status":"O"},{"AccNo":74,"Name":"Sheela R","BranchID":"BR3","Balance":8600,"ProductID":"SA","DOO":"1993-02-21","Status":"O"},{"AccNo":75,"Name":"Pankaj R","BranchID":"BR3","Balance":9600,"ProductID":"FA","DOO":"1993-03-21","Status":"O"},{"AccNo":76,"Name":"Ankita R","BranchID":"BR3","Balance":10600,"ProductID":"RD","DOO":"1993-04-21","Status":"D"},{"AccNo":77,"Name":"Sushant D","BranchID":"BR4","Balance":7700,"ProductID":"CA","DOO":"1993-05-21","Status":"O"},{"AccNo":78,"Name":"Shreyash D","BranchID":"BR4","Balance":8700,"ProductID":"SA","DOO":"1993-06-21","Status":"O"}]'

SELECT JSON_VALUE(P.value, '$.AccNo') AS AccNo,
		JSON_VALUE(P.value, '$.Name') AS Name,
		JSON_VALUE(P.value, '$.BranchID') AS BranchID,
		JSON_VALUE(P.value, '$.Balance') AS Balance,
		JSON_VALUE(P.value, '$.ProductID') AS ProductID,
		JSON_VALUE(P.value, '$.DOO') AS DOO,
		JSON_VALUE(P.value, '$.Status') AS Status
FROM OPENJSON(@JSON2) P

--Retrieve nested data from JSON
DECLARE @JSON3 NVARCHAR(MAX) 
SELECT @JSON3 =
N'
[
  {
    "ID": 1,
    "Name": {
      "FirstName": "Nikhil",
      "MiddleName": null,
      "LastName": null
    }
  },
  {
    "ID": 2,
    "Name": {
      "FirstName": null,
      "MiddleName": "Pralhad",
      "LastName": null
    }
  },
  {
    "ID": 3,
    "Name": {
      "FirstName": null,
      "MiddleName": null,
      "LastName": "Jagnade"
    }
  },
  {
    "ID": 4,
    "Name": {
      "FirstName": null,
      "MiddleName": "Vinay",
      "LastName": null
    }
  }
]
'
SELECT JSON_VALUE(P.value, '$.ID') AS ID,
		JSON_VALUE(P.value, '$.Name.FirstName') AS FirstName,
		JSON_VALUE(P.value, '$.Name.MiddleName') AS MiddleName,
		JSON_VALUE(P.value, '$.Name.LastName') AS LastName
FROM OPENJSON(@JSON3) P

--Extract Nested data from JSON
DECLARE @JSON4 NVARCHAR(MAX) 
SELECT @JSON4 =
N'
[
	{
		"id": "0001",
		"type": "donut",
		"name": "Cake",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" },
						{ "id": "1002", "type": "Chocolate" },
						{ "id": "1003", "type": "Blueberry" },
						{ "id": "1004", "type": "Devils Food" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5005", "type": "Sugar" },
				{ "id": "5007", "type": "Powdered Sugar" },
				{ "id": "5006", "type": "Chocolate with Sprinkles" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	},
	{
		"id": "0002",
		"type": "donut",
		"name": "Raised",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5005", "type": "Sugar" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	},
	{
		"id": "0003",
		"type": "donut",
		"name": "Old Fashioned",
		"ppu": 0.55,
		"batters":
			{
				"batter":
					[
						{ "id": "1001", "type": "Regular" },
						{ "id": "1002", "type": "Chocolate" }
					]
			},
		"topping":
			[
				{ "id": "5001", "type": "None" },
				{ "id": "5002", "type": "Glazed" },
				{ "id": "5003", "type": "Chocolate" },
				{ "id": "5004", "type": "Maple" }
			]
	}
]
'
SELECT JSON_VALUE(P.value, '$.id') AS id,
		JSON_VALUE(P.value, '$.type') AS type,
		JSON_VALUE(P.value, '$.name') AS name,
		JSON_VALUE(P.value, '$.ppu') AS ppu,
		JSON_VALUE(q.value, '$.id') AS batter_id,
		JSON_VALUE(q.value, '$.type') AS batter_type,
		JSON_VALUE(r.value, '$.id') AS topping_id,
		JSON_VALUE(r.value, '$.type') AS topping_type
FROM OPENJSON(@JSON4) P
CROSS APPLY OPENJSON(p.value, '$.batters.batter') q
CROSS APPLY OPENJSON(p.value, '$.topping') r

--Read Dat From External JSON File - Cakes_Data
DECLARE @JSON6 NVARCHAR(MAX)
SELECT @JSON6 = BULKCOLUMN
FROM OPENROWSET (BULK 'C:\Users\nikhiljagnade\OneDrive\Desktop\Mac OS\Power BI\Adv_SQL_Queries_Learning\Extra Files\Cakes_Data.json', SINGLE_CLOB) IMPORT
--Check JSON Data Validity
IF(ISJSON(@JSON6)=1)
	PRINT 'Valid Json File'
ELSE
	PRINT 'Invalid Json File'
--SELECT Query to get and display JSON file data
SELECT JSON_VALUE(P.value, '$.id') AS id,
		JSON_VALUE(P.value, '$.type') AS type,
		JSON_VALUE(P.value, '$.name') AS name,
		JSON_VALUE(P.value, '$.ppu') AS ppu,
		JSON_VALUE(q.value, '$.id') AS batter_id,
		JSON_VALUE(q.value, '$.type') AS batter_type,
		JSON_VALUE(r.value, '$.id') AS topping_id,
		JSON_VALUE(r.value, '$.type') AS topping_type
FROM OPENJSON(@JSON6) P
CROSS APPLY OPENJSON(p.value, '$.batters.batter') q
CROSS APPLY OPENJSON(p.value, '$.topping') r


--INNER Join with AccountMaster & TransactionMaster
DECLARE @JSON_1 NVARCHAR(MAX) = '[{"AccNo":60,"Name":"Nikhil Jagnade","BranchID":"BR1","Balance":7000,"ProductID":"CA","DOO":"1992-01-21","Status":"O"},{"AccNo":61,"Name":"Praful J","BranchID":"BR1","Balance":8000,"ProductID":"SA","DOO":"1992-02-21","Status":"O"},{"AccNo":62,"Name":"Harshal J","BranchID":"BR1","Balance":9000,"ProductID":"FA","DOO":"1992-03-21","Status":"O"},{"AccNo":63,"Name":"Shraddha J","BranchID":"BR1","Balance":10000,"ProductID":"RD","DOO":"1992-04-21","Status":"O"},{"AccNo":64,"Name":"Ved J","BranchID":"BR1","Balance":11000,"ProductID":"LA","DOO":"1992-05-21","Status":"O"},{"AccNo":65,"Name":"Kalpna J","BranchID":"BR1","Balance":12000,"ProductID":"FD","DOO":"1992-06-21","Status":"D"},{"AccNo":66,"Name":"Rangrao W","BranchID":"BR2","Balance":7500,"ProductID":"CA","DOO":"1992-07-21","Status":"O"},{"AccNo":67,"Name":"Jyoti W","BranchID":"BR2","Balance":8500,"ProductID":"SA","DOO":"1992-08-21","Status":"O"},{"AccNo":69,"Name":"Pooja W","BranchID":"BR2","Balance":9500,"ProductID":"FA","DOO":"1992-09-21","Status":"O"},{"AccNo":70,"Name":"Bhushan W","BranchID":"BR2","Balance":10500,"ProductID":"RD","DOO":"1992-10-21","Status":"D"},{"AccNo":71,"Name":"Shrani W","BranchID":"BR2","Balance":11500,"ProductID":"LA","DOO":"1992-11-21","Status":"O"},{"AccNo":72,"Name":"Shyam W","BranchID":"BR2","Balance":12500,"ProductID":"FD","DOO":"1992-12-21","Status":"O"},{"AccNo":73,"Name":"Daulat R","BranchID":"BR3","Balance":7600,"ProductID":"CA","DOO":"1993-01-21","Status":"O"},{"AccNo":74,"Name":"Sheela R","BranchID":"BR3","Balance":8600,"ProductID":"SA","DOO":"1993-02-21","Status":"O"},{"AccNo":75,"Name":"Pankaj R","BranchID":"BR3","Balance":9600,"ProductID":"FA","DOO":"1993-03-21","Status":"O"},{"AccNo":76,"Name":"Ankita R","BranchID":"BR3","Balance":10600,"ProductID":"RD","DOO":"1993-04-21","Status":"D"},{"AccNo":77,"Name":"Sushant D","BranchID":"BR4","Balance":7700,"ProductID":"CA","DOO":"1993-05-21","Status":"O"},{"AccNo":78,"Name":"Shreyash D","BranchID":"BR4","Balance":8700,"ProductID":"SA","DOO":"1993-06-21","Status":"O"}]'

SELECT JsonData.*, TM.DOO AS TxnDate, TM.Amount AS TxnAmount
FROM OPENJSON(@JSON_1)
WITH(
	AccNo INT '$.AccNo',
	Name VARCHAR(50) '$.Name',
	BranchID VARCHAR(20) '$.BranchID',
	Balance MONEY '$.Balance',
	ProductID VARCHAR(20) '$.ProductID',
	DOO DATE '$.DOO',
	Status VARCHAR(2) '$.Status'
)
JsonData
INNER JOIN TransactionMaster TM 
ON TM.AccNo = JsonData.AccNo


--Read Dat From External JSON File - Json_Data
DECLARE @JSON5 NVARCHAR(MAX)
SELECT @JSON5 = BULKCOLUMN
FROM OPENROWSET (BULK 'C:\Users\nikhiljagnade\OneDrive\Desktop\Mac OS\Power BI\Adv_SQL_Queries_Learning\Extra Files\Json_Data.json', SINGLE_CLOB) IMPORT
--Check JSON Data Validity
IF(ISJSON(@JSON5)=1)
	PRINT 'Valid Json File'
ELSE
	PRINT 'Invalid Json File'
--SELECT Query to get and display JSON file data
SELECT JSON_VALUE(a.value, '$.id') AS feeds_id,
		JSON_VALUE(a.value, '$.title') AS feeds_title,
		JSON_VALUE(a.value, '$.description') AS feeds_description,
		JSON_VALUE(a.value, '$.location') AS feeds_location,
		JSON_VALUE(a.value, '$.lng') AS feeds_lng,
		JSON_VALUE(a.value, '$.lat') AS feeds_lat,
		JSON_VALUE(a.value, '$.userId') AS feeds_userId,
		JSON_VALUE(a.value, '$.name') AS feeds_name,
		JSON_VALUE(a.value, '$.isdeleted') AS feeds_isdeleted,
		JSON_VALUE(a.value, '$.profilePicture') AS feeds_profilePicture,
		JSON_VALUE(a.value, '$.videoUrl') AS feeds_videoUrl,
		JSON_VALUE(a.value, '$.images') AS feeds_images,
		JSON_VALUE(a.value, '$.mediatype') AS feeds_mediatype,
		JSON_VALUE(a.value, '$.imagePaths') AS feeds_imagePaths,
		JSON_VALUE(a.value, '$.feedsComment') AS feeds_Comment,
		JSON_VALUE(a.value, '$.commentCount') AS feeds_commentCount,
		JSON_VALUE(b.value, '$.id') AS feeds_multiMedia_id,
		JSON_VALUE(b.value, '$.name') AS feeds_multiMedia_name,
		JSON_VALUE(b.value, '$.description') AS feeds_multiMedia_description,
		JSON_VALUE(b.value, '$.url') AS feeds_multiMedia_url,
		JSON_VALUE(b.value, '$.mediatype') AS feeds_multiMedia_mediatype,
		JSON_VALUE(b.value, '$.likeCount') AS feeds_multiMedia_likeCount,
		JSON_VALUE(b.value, '$.place') AS feeds_multiMedia_place,
		JSON_VALUE(b.value, '$.createAt') AS feeds_multiMedia_createAt,
		JSON_VALUE(c.value, '$.likes') AS feeds_likeDislike_likes,
		JSON_VALUE(c.value, '$.dislikes') AS feeds_likeDislike_dislikes,
		JSON_VALUE(c.value, '$.userAction') AS feeds_likeDislike_userAction,
		JSON_VALUE(a.value, '$.createdAt') AS feeds_createdAt,
		JSON_VALUE(a.value, '$.code') AS feeds_code,
		JSON_VALUE(a.value, '$.msg') AS feeds_msg
FROM OPENJSON(@JSON5, '$.feeds') a
CROSS APPLY OPENJSON(a.value, '$.multiMedia') b
CROSS APPLY OPENJSON(a.value, '$.likeDislike') c
