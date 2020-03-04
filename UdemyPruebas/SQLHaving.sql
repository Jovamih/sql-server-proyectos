USE Northwind
SELECT * FROM [dbo].[Employees]
SELECT [TitleOfCourtesy] , COUNT([EmployeeID]) AS CANTIDAD FROM [dbo].[Employees]   
							GROUP BY [TitleOfCourtesy] having COUNT(*)>1
