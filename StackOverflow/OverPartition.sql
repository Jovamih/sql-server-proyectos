select top 25 percent*from [Purchasing].[PurchaseOrderHeader]
go
select EmployeeID,
		vendorID,
		count(EmployeeID) OVER(PARTITION BY EmployeeID ) AS Cantidad 
		from [Purchasing].[PurchaseOrderHeader]
--valor inicial UNBOUNDING PRECEDING
--- valor final ROW CURRENT
SELECT COUNT(EmployeeID) as [count]  from [Purchasing].[PurchaseOrderHeader] where EmployeeID=250

select EmployeeID, count(distinct vendorID) from [Purchasing].[PurchaseOrderHeader] group by EmployeeID

go

EXECUTE AS USER='dbo'
SELECT current_user
go

SELECT*FROM Person.Password