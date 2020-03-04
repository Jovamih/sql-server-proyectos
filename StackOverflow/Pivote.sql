go
select current_user
use AdventureWorks2017
go
SELECT VendorID, [250] AS Emp1, [251] AS Emp2, [256] AS Emp3, [257] AS Emp4, [260] AS Emp5  
FROM   
(SELECT PurchaseOrderID, EmployeeID, VendorID  
FROM Purchasing.PurchaseOrderHeader) p  
PIVOT  
(  
COUNT (PurchaseOrderID)  
FOR EmployeeID IN  
( [250], [251], [256], [257], [260] )  
) AS pvt  
ORDER BY pvt.VendorID;
select * from [Purchasing].[Vendor]
go
select  EmployeeID,count(EmployeeID) from Purchasing.PurchaseOrderHeader group by EmployeeID HAVING (COUNT(DISTINCT VendorID)>80) order by EmployeeID

select EmployeeID,count(distinct VendorID) as VendorsDistinct from Purchasing.PurchaseOrderHeader group by EmployeeID having(count(distinct VendorID)>70)
go
---
select VendorID,count(VendorID) as NumberVendor from Purchasing.PurchaseOrderHeader where EmployeeID=251 group by VendorID
select count(VendorID) from Purchasing.PurchaseOrderHeader where EmployeeID=251

go
print @@servername
print @@version
select SERVERPROPERTY('LoginName') as Maquina
select db_name()
execute sp_who2
select*from sys.tables

exec sp_helpdb