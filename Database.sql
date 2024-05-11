
--Create database
CREATE DATABASE SampleDB

/*
When we create a database then two files gets created
.MDF File - Data file (Contains actual data) 
.LDF File - Transactiol log file (Used to recover the database)
*/

--Alter database
ALTER DATABASE SampleDB MODIFY NAME = Sample_DB

--Alter database using SYSTEM STORED PROCEDURE
EXECUTE sp_renamedb 'Sample_DB', 'SampleDB1'

--Delete database
DROP DATABASE SampleDB1

/* 
We cannot drop a databse if it is currently in use. You get an error stating that "Cannot drop database databasename because it is currently in use"
If other users are using it then we need to put it on single use mode and then drop it
*/

--SET Database on SINGLE USER MODE WITH ROLLBACK IMMEDIATE OPTION
ALTER DATABASE SampleDB1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE 
DROP DATABASE SampleDB1
/*
WITH ROLLBACK IMMEDIATE OPTION, will rollback all immediate transactions and close the connection the connection to the database
NOTE: System database cannot be dropped only user defined database can be dropped.
*/

/*
SCHEMA/TABLE - Metadata (Data about data)
Table structure is schema/metadata about table
Schema is schema/metadata
*/
--Create Schema
CREATE SCHEMA Company

--Default [dbo].[employee] gets created
CREATE TABLE employee(
	Id INT,
	Name VARCHAR(20)
)

--Create [company].[employee]
CREATE TABLE company.employee(
	Id INT,
	Name VARCHAR(20)
)

--Drop Schema - We can't drop schema untile and unless all tables gets deleted referring to schema
DROP SCHEMA company