--operadores and
SELECT[Country] FROM [dbo].[Employees]
SELECT * FROM [dbo].[Employees] where [LastName] in ('Davolio','King')
SELECT * FROM [dbo].[Employees] where [TitleOfCourtesy] NOT LIKE '%[Mm]%' ORDER BY [FirstName] asc
--operaorres IN
SELECT * FROM [dbo].[Employees] where [Country] NOT IN('USA','BRA') ORDER BY [FirstName]

--Operadores BETWEEN
select * from Employees
SELECT * FROM [dbo].[Employees] where [EmployeeID] BETWEEN 1 AND 5
select * from [dbo].[Employees] where [BirthDate] BETWEEN '1930-01-01' AND '1991-12-12'
