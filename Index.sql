/*INDEX - faster data retrival
TWO TYPES -
1. CLUSTURED INDEX (Only 1 per table)
	a) Unique Clustered Index (PK (No duplicate value) + Clustered Index)
	b) Non Unique Clustered Index (Clustered Index + Duplicate Values allow)
2. NON-CLUSTURED INDEX (Max 999 per table)
	a) Unique Non Clustered Index (UK (No duplicate value) + Clustered Index)
	b) Non Unique Clustered Index (Clustered Index + Duplicate values allow)

We can CREATE, DROP, ENABLE & DISABLE Index on column in a table

--Create index
CREATE CLUSTERED INDEX index_name ON table_name(column_name)
CREATE INDEX or NONCLUSTERED INDEX index_name ON table_name(column_name)

--Drop index
DROP INDEX table_name.index_name

--Disable index
ALTER INDEX index_name ON table_name DISABLE
--Enable index
ALTER INDEX index_name ON table_name ENABLE
*/

USE Practice_DB

--HEAP Structure
CREATE TABLE TB_1(
	ID INT,
	Name VARCHAR(50)
)
INSERT INTO TB_1 VALUES(7, 'Nik'),
							(9, 'Pra'),
							(2, 'Har'),
							(1, 'Abc'),
							(5, 'Xyz'),
							(4, 'Lmn')

--Data retrieval query
SELECT * FROM TB_1 -- Data is not arranged in sorted order as inserted in unsorted order without index

--Check index
sp_help 'TB_1'
sp_helpindex 'TB_1'

--CREATE CLUSTURED INDEX - PK automatically Clustured Index gets created & INDEX pages gets created, Only one Clustered Index in a table
CREATE TABLE IndexTB(
ID INT NOT NULL,
Name VARCHAR(50),
PRIMARY KEY (ID)
)
INSERT INTO IndexTB VALUES(1, 'Nik'),
							(3, 'Pra'),
							(2, 'Har'),
							(6, 'Abc'),
							(5, 'Xyz'),
							(4, 'Lmn')

--We Inserted data randomly but using PK and Clustered Index it is sorted
SELECT * FROM IndexTB

--Create second clustered Index 
/* 
1. Data Sorting, 
2. Index pages gets created 
3. It will not create PK
4. We can also insert duplicate data as no PK 
*/
CREATE CLUSTERED INDEX IX_IndexTB_Name
ON IndexTB(Name) --Error: Cannot create more than one clustered index on table 'IndexTB'. Drop the existing clustered index 'PK__IndexTB__3214EC2748DED5BB' before creating another.

--Check already applicable Index on Table
sp_helpindex IndexTB -- 1 Index present

--DROP Index already present
DROP INDEX IndexTB.PK__IndexTB__3214EC2748DED5BB
--Error: An explicit DROP INDEX is not allowed on index 'IndexTB.PK__IndexTB__3214EC2748DED5BB'. It is being used for PRIMARY KEY constraint enforcement.

--Create Non-Clustered Index - Can create multiple NonClustered Index on Non PK columns
CREATE NONCLUSTERED INDEX IX_IndexTB_Name
ON IndexTB(Name) 

--Check already applicable Index on Table
sp_helpindex IndexTB --2 Index present

/* EXAMPLE - Scenario based
1. Create heap table
2. Assign Clustered index on Name column
3. Assign PK on ID column
*/
--First create heap table
CREATE TABLE TB_4(
ID INT NOT NULL,
Name VARCHAR(50)
)
INSERT INTO TB_4 VALUES(1, 'Nik'),
							(3, 'Pra'),
							(2, 'Har'),
							(6, 'Abc'),
							(5, 'Xyz'),
							(4, 'Lmn')

--Create clustered index on Name Col
CREATE CLUSTERED INDEX CI_TB4_Name
ON TB_4(Name) --CI created on Name Column but No PK in table

--Create PK Constraint on table
ALTER TABLE TB_4
ADD CONSTRAINT PRIMARY KEY ON ID --Non Clustered Unique Index gets created because one table could have only one Clustered Index

/* EXAMPLE - Scenario based
1. create table with PK - Default clustered Index
2. DROP INDEX --Error
3. DROP PK_CONSTRAINT --Check Clustered Index dropped automatically or not
4. Create Clustered Index on Non PK Column
5. Drop Index --works as no PK assign on column
*/

--1. create table with PK - Default clustered Index
CREATE TABLE TB_2(
ID INT NOT NULL,
Name VARCHAR(50),
PRIMARY KEY (ID)
)
INSERT INTO TB_2 VALUES(1, 'Nik'),
							(3, 'Pra'),
							(2, 'Har'),
							(6, 'Abc'),
							(5, 'Xyz'),
							(4, 'Lmn')

--2. DROP INDEX --Error
sp_helpindex 'TB_2'

--Error: An explicit DROP INDEX is not allowed on index 'TB_2.PK__TB_2__3214EC273F6D68F6'. It is being used for PRIMARY KEY constraint enforcement.
DROP INDEX TB_2.PK__TB_2__3214EC273F6D68F6

sp_help 'TB_2'

--Drop PK__TB_2__3214EC273F6D68F6 Constraint
ALTER TABLE TB_2
DROP CONSTRAINT PK__TB_2__3214EC273F6D68F6 --Constraint dropped successfully + Clustered Index also

--Error: Cannot drop the index 'TB_2.PK__TB_2__3214EC273F6D68F6', because it does not exist or you do not have permission.
DROP INDEX TB_2.PK__TB_2__3214EC273F6D68F6
