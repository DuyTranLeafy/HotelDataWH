--CREATE DATABASE HotelStage
--go
--CREATE SCHEMA hotel
--go
-- staging bảng Customers
SELECT *
INTO [hotel].[stgHotelCustomers]
FROM [Hotel].[dbo].[Customers]

-- staging bảng Employees
SELECT *
INTO [hotel].[stgHotelEmployees]
FROM [Hotel].[dbo].[Employees]

-- staging bảng Date
SELECT *
INTO [hotel].[stgHotelDate]
FROM [Temp].[dbo].['Date dimension$']
WHERE Year between 2015 and 2017

-- staging bảng FactSales
SELECT b.CustomerID,
	b.EmployeeID,
	b.BookingID,
	p.PaymentDate,
	b.RoomNumber,
	r.RoomType,
	r.BedType,
	r.TypeCost,
	r.BedCost,
	b.GuestCount,
	p.Discount,
	p.TaxRate
INTO [hotel].[stgHotelSales]
FROM [Hotel].[dbo].[Payments] p JOIN [Hotel].[dbo].[Bookings] b ON p.BookingId=b.BookingID
	JOIN (SELECT r.RoomNumber, b.BedType, b.BedCost, rt.RoomType, rt.TypeCost FROM [Hotel].[dbo].[Rooms] r JOIN 
										[Hotel].[dbo].[BedTypes] b ON r.BedTypeID=b.BedTypeID JOIN 
										[Hotel].[dbo].[RoomTypes] rt ON r.RoomTypeID=rt.RoomTypeID) r ON b.RoomNumber=r.RoomNumber


-- staging bảng FactBooking
SELECT [CustomerID],
	[BookingID],
	[EmployeeID],
	r.RoomNumber,
	[ArrvialDate],
	[DepartureDate],
	r.RoomType,
	r.BedType,
	[GuestCount],
	[ReservationStatus],
	r.TypeCost,
	r.BedCost
INTO [hotel].[stgHotelBookings]
FROM [Hotel].[dbo].[Bookings] b JOIN (SELECT r.RoomNumber, b.BedType, b.BedCost, rt.RoomType, rt.TypeCost FROM [Hotel].[dbo].[Rooms] r JOIN 
										[Hotel].[dbo].[BedTypes] b ON r.BedTypeID=b.BedTypeID JOIN 
										[Hotel].[dbo].[RoomTypes] rt ON r.RoomTypeID=rt.RoomTypeID) r ON b.RoomNumber=r.RoomNumber







