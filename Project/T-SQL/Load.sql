use HotelDW

-- load DimCustomers
INSERT INTO [hotel].[DimCustomers]
	( [CustomerID], [FirstName], [LastName], [BirthDate], [Email], [Phone])
SELECT [CustomerID], [FirstName], [LastName], [BirthDate], [Email], [Phone]
FROM [HotelStage].[hotel].[stgHotelCustomers]

-- load DimEmployees
INSERT INTO [hotel].[DimEmployees]
	([EmployeeID], [EmployeeName], [Title], [City], [Country], [HireDate])
SELECT [EmployeeID], [EmployeeName], [Title], [City],[Country] , [HireDate]
FROM [HotelStage].[hotel].[stgHotelEmployees]


-- load DimDate 
INSERT INTO [hotel].[DimDate] 
	([DateKey], [Date], [DayOfWeek], [DayName], [DayOfMonth], [DayOfYear], 
	[WeekOfYear], [MonthName], [MonthOfYear], [Quarter], [Year], [IsWeekday])
SELECT [date key],[full date],[day of week],[day name],[day num in month], 
		[day num overall],[week num in year],[month name],[month],[quarter],[year], [weekday flag]
FROM [HotelStage].[hotel].[stgHotelDate]


-- load FactBooking
INSERT INTO [hotel].[FactBookings]
	([CustomerKey], [BookingID], [EmployeeKey], [RoomNumber], [ArrivalDateKey], 
	[DepartureDateKey], [RoomType], [BedType], [GuestCount], [BookingStatus], [RoomCost], [BedCost], [TotalPrice])
SELECT dc.CustomerKey, fb.BookingID, de.EmployeeKey, fb.RoomNumber, d1.DateKey as ArrivalDateKey, d2.DateKey as DepartureDateKey,
	fb.RoomType, fb.BedType, fb.GuestCount, fb.ReservationStatus as BookingStatus, fb.TypeCost as RoomCost, fb.BedCost,
	SUM(fb.BedCost+fb.TypeCost) as TotalPrice
FROM [HotelStage].[hotel].[stgHotelBookings] fb JOIN			
		[HotelDW].[hotel].[DimCustomers] dc ON fb.CustomerID=dc.CustomerID
		JOIN [HotelDW].[hotel].[DimEmployees] de ON fb.EmployeeID=de.EmployeeID
		JOIN [HotelDW].[hotel].[DimDate] d1 ON fb.ArrvialDate=d1.Date
		JOIN [HotelDW].[hotel].[DimDate] d2 ON fb.DepartureDate=d2.Date
GROUP BY dc.CustomerKey, fb.BookingID, de.EmployeeKey, fb.RoomNumber, d1.DateKey, d2.DateKey,
	fb.RoomType, fb.BedType, fb.GuestCount, fb.ReservationStatus, fb.TypeCost, fb.BedCost


-- load FactSales
INSERT INTO [hotel].[FactSales]
	([CustomerKey],[EmployeeKey],[SettlementDateKey] ,[BookingID], [RoomNumber], [RoomType], [BedType], 
	[RoomCost], [BedCost],[GuestNumber],[Discount],[Tax],[Total])
SELECT dc.CustomerKey, de.EmployeeKey,d.DateKey ,fs.BookingID, fs.RoomNumber, fs.RoomType,
	fs.BedType, fs.TypeCost, fs.BedCost, fs.GuestCount, fs.Discount, fs.TaxRate, 
	SUM((fs.BedCost+fs.TypeCost)*(1+fs.TaxRate)-(fs.BedCost+fs.TypeCost)*fs.Discount) as Total
FROM [HotelStage].[hotel].[stgHotelSales] fs JOIN
	[HotelDW].[hotel].[DimCustomers] dc ON fs.CustomerID=dc.CustomerID
	JOIN [HotelDW].[hotel].[DimEmployees] de ON fs.EmployeeID=de.EmployeeID
	JOIN [HotelDW].[hotel].[DimDate] d ON fs.PaymentDate=d.Date
GROUP BY dc.CustomerKey, de.EmployeeKey,d.DateKey ,fs.BookingID, fs.RoomNumber, fs.RoomType,
	fs.BedType, fs.TypeCost, fs.BedCost, fs.GuestCount, fs.Discount, fs.TaxRate

