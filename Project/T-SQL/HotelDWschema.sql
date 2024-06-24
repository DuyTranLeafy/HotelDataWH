/****** Object:  Database HotelDW    Script Date: 17-May-24 10:21:55 AM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE HotelDW
GO
CREATE DATABASE HotelDW
GO
ALTER DATABASE HotelDW
SET RECOVERY SIMPLE
GO
*/
USE HotelDW
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA hotel
GO






/* Drop table hotel.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'hotel.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE hotel.DimDate 
;

/* Create table hotel.DimDate */
CREATE TABLE hotel.DimDate (
   [DateKey]  int IDENTITY  NOT NULL
,  [Date]  datetime   NULL
,  [DayOfWeek]  float   NOT NULL
,  [DayName]  nvarchar(255)   NOT NULL
,  [DayOfMonth]  float   NOT NULL
,  [DayOfYear]  float   NOT NULL
,  [WeekOfYear]  float   NOT NULL
,  [MonthName]  nvarchar(255)   NOT NULL
,  [MonthOfYear]  float   NOT NULL
,  [Quarter]  float   NOT NULL
,  [Year]  float   NOT NULL
,  [IsWeekday]  nvarchar(255)   NOT NULL
, CONSTRAINT [PK_hotel.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'hotel', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimDate
;

SET IDENTITY_INSERT hotel.DimDate ON
;
INSERT INTO hotel.DimDate (DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, Year, IsWeekday)
VALUES (-1, '31-Dec-1899', 0, 'Unknown', 0, 0, 0, '0', 0, 0, 0, '?')
;
SET IDENTITY_INSERT hotel.DimDate OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[hotel].[Date]'))
DROP VIEW [hotel].[Date]
GO
CREATE VIEW [hotel].[Date] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [Year] AS [Year]
, [IsWeekday] AS [IsWeekday]
FROM hotel.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekday', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
;





/* Drop table hotel.DimCustomers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'hotel.DimCustomers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE hotel.DimCustomers 
;

/* Create table hotel.DimCustomers */
CREATE TABLE hotel.DimCustomers (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nvarchar(50)   NOT NULL
,  [FirstName]  nvarchar(50)   NULL
,  [LastName]  nvarchar(50)   NULL
,  [BirthDate]  datetime   NULL
,  [Email]  nvarchar(50)   NULL
,  [Phone]  float   NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_hotel.DimCustomers] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customers', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'hotel', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimCustomers
;

SET IDENTITY_INSERT hotel.DimCustomers ON
;
INSERT INTO hotel.DimCustomers (CustomerKey, CustomerID, FirstName, LastName, BirthDate, Email, Phone, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'None', 'No Customer', 'None', '01-Jan-00', 'None', 0, 'Y', '1899-12-31 00:00:00.000', '31-Dec-9999', 'N/A')
;
SET IDENTITY_INSERT hotel.DimCustomers OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[hotel].[Customers]'))
DROP VIEW [hotel].[Customers]
GO
CREATE VIEW [hotel].[Customers] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [FirstName] AS [FirstName]
, [LastName] AS [LastName]
, [BirthDate] AS [BirthDate]
, [Email] AS [EmailCustomer]
, [Phone] AS [PhoneCustomer]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM hotel.DimCustomers
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FirstName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'LastName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BirthDate', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmailCustomer', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PhoneCustomer', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'24-Jan-11', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derive', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derive', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derive', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derive', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derive', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'FirstName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'LastName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BirthDate', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Email', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Phone', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Email'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'Phone'; 
;





/* Drop table hotel.DimEmployees */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'hotel.DimEmployees') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE hotel.DimEmployees 
;

/* Create table hotel.DimEmployees */
CREATE TABLE hotel.DimEmployees (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  nvarchar(50)   NOT NULL
,  [EmployeeName]  nvarchar(50)   NULL
,  [Title]  nvarchar(50)   NULL
,  [City]  nvarchar(50)   NULL
,  [Country]  nvarchar(50)   NULL
,  [HireDate]  date   NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '31-Dec-9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_hotel.DimEmployees] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimEmployees
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employees', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimEmployees
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'hotel', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimEmployees
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=DimEmployees
;

SET IDENTITY_INSERT hotel.DimEmployees ON
;
INSERT INTO hotel.DimEmployees (EmployeeKey, EmployeeID, EmployeeName, Title, City, Country, HireDate, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'None', 'None', '', '', '', 'Y', '31-Dec-1899', '31-Dec-9999', 'N/A')
;
SET IDENTITY_INSERT hotel.DimEmployees OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[hotel].[Employees]'))
DROP VIEW [hotel].[Employees]
GO
CREATE VIEW [hotel].[Employees] AS 
SELECT [EmployeeKey] AS [EmployeeKey]
, [EmployeeID] AS [EmployeeID]
, [EmployeeName] AS [EmployeeName]
, [Title] AS [EmployeeTitle]
, [City] AS [City]
, [Country] AS [Country]
, [HireDate] AS [HireDate]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM hotel.DimEmployees
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeTitle', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HireDate', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'24-Jan-11', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'EmployeeID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'EmployeeName', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'EmployeeTitle', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'HireDate', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
;





/* Drop table hotel.FactSales */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'hotel.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE hotel.FactSales 
;

/* Create table hotel.FactSales */
CREATE TABLE hotel.FactSales (
   [CustomerKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [BookingID]  nvarchar(50)   NOT NULL
,  [RoomNumber]  float   NOT NULL
,  [SettlementDateKey]  int   NOT NULL
,  [RoomType]  nvarchar(50)   NULL
,  [BedType]  nvarchar(50)   NULL
,  [RoomCost]  money   NULL
,  [BedCost]  money   NULL
,  [GuestNumber]  float   NULL
,  [Discount]  float   NULL
,  [Tax]  float   NULL
,  [Total]  money   NULL
, CONSTRAINT [PK_hotel.FactSales] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [BookingID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Sales', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'hotel', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactSales
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[hotel].[Sales]'))
DROP VIEW [hotel].[Sales]
GO
CREATE VIEW [hotel].[Sales] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [EmployeeKey] AS [EmployeeKey]
, [BookingID] AS [BookingID]
, [RoomNumber] AS [RoomNumber]
, [SettlementDateKey] AS [SettlementDateKey]
, [RoomType] AS [RoomType]
, [BedType] AS [BedType]
, [RoomCost] AS [RoomCost]
, [BedCost] AS [BedCost]
, [GuestNumber] AS [GuestNumber]
, [Discount] AS [Discount]
, [Tax] AS [Tax]
, [Total] AS [Total]
FROM hotel.FactSales
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BookingID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SettlementDateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SettlementDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BedType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BedCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'GuestNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Discount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Tax', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Total', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Total'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 4', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SettlementDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SettlementDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amounts', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Total'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimCustomer.CustomerKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimEmployee.EmployeeKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key Lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SettlementDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Bookings', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Rooms', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'RoomTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'BedTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'RoomTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'BedTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Bookings', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Payments', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Payments', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BookingID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RoomNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RoomType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BedType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TypeCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BedCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'GuestCount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Discount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TaxRate', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RoomCost+BedCost+TaxRate-(RoomCost+BedCost)*Discount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Total'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'GuestNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Discount'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Tax'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N' money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Total'; 
;





/* Drop table hotel.FactBookings */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'hotel.FactBookings') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE hotel.FactBookings 
;

/* Create table hotel.FactBookings */
CREATE TABLE hotel.FactBookings (
   [CustomerKey]  int   NOT NULL
,  [BookingID]  nvarchar(50)   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [RoomNumber]  float   NOT NULL
,  [ArrivalDateKey]  int   NOT NULL
,  [DepartureDateKey]  int   NOT NULL
,  [RoomType]  nvarchar(50)   NULL
,  [BedType]  nvarchar(50)   NULL
,  [GuestCount]  float   NULL
,  [BookingStatus]  nvarchar(50)   NULL
,  [RoomCost]  money   NULL
,  [BedCost]  money   NULL
,  [TotalPrice]  money   NULL
, CONSTRAINT [PK_hotel.FactBookings] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [BookingID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactBookings
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank Fact', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactBookings
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'hotel', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactBookings
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=hotel, @level1type=N'TABLE', @level1name=FactBookings
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[hotel].[Blank Fact]'))
DROP VIEW [hotel].[Blank Fact]
GO
CREATE VIEW [hotel].[Blank Fact] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [BookingID] AS [BookingID]
, [EmployeeKey] AS [EmployeeKey]
, [RoomNumber] AS [RoomNumber]
, [ArrivalDateKey] AS [ArrivalDateKey]
, [DepartureDateKey] AS [DepartureDateKey]
, [RoomType] AS [RoomType]
, [BedType] AS [BedType]
, [GuestCount] AS [GuestCount]
, [BookingStatus] AS [BookingStatus]
, [RoomCost] AS [RoomCost]
, [BedCost] AS [BedCost]
, [TotalPrice] AS [TotalPrice]
FROM hotel.FactBookings
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BookingID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ArrivalDateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'ArrivalDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DepartureDateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'DepartureDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BedType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'GuestCount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BookingStatus', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RoomCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BedCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TotalPrice', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'TotalPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimCustomer', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimEmployee', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimRoom', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimArrival', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'ArrivalDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDeparture', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'DepartureDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name Room Type to DimRoomType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name Bed Type to DimBedType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count to DimGuest', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Status to DimBooking', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Price to DimTotal', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'TotalPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup form DimCustomers.CustomerKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup form DimEmployees.EmployeeKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'RoomNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key Lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'ArrivalDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key Lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'DepartureDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel ', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel ', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Hotel ', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Bookings', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Rooms', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'RoomTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'BedTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Bookings', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Bookings', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'RoomTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'BedTypes', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BookingID', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RoomNumber', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RoomType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BedType', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'GuestCount', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ReservationStatus', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TypeCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BedCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TypeCost + BedCost', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'TotalPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomNumber'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'float', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'GuestCount'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BookingStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'RoomCost'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'BedCost'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'hotel', @level1type=N'TABLE', @level1name=N'FactBookings', @level2type=N'COLUMN', @level2name=N'TotalPrice'; 
;
ALTER TABLE hotel.FactSales ADD CONSTRAINT
   FK_hotel_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES hotel.DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactSales ADD CONSTRAINT
   FK_hotel_FactSales_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES hotel.DimEmployees
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactSales ADD CONSTRAINT
   FK_hotel_FactSales_SettlementDateKey FOREIGN KEY
   (
   SettlementDateKey
   ) REFERENCES hotel.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactBookings ADD CONSTRAINT
   FK_hotel_FactBookings_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES hotel.DimCustomers
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactBookings ADD CONSTRAINT
   FK_hotel_FactBookings_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES hotel.DimEmployees
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactBookings ADD CONSTRAINT
   FK_hotel_FactBookings_ArrivalDateKey FOREIGN KEY
   (
   ArrivalDateKey
   ) REFERENCES hotel.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE hotel.FactBookings ADD CONSTRAINT
   FK_hotel_FactBookings_DepartureDateKey FOREIGN KEY
   (
   DepartureDateKey
   ) REFERENCES hotel.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
