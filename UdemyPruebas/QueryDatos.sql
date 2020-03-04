SELECT * FROM [dbo].[Medico]
UPDATE [dbo].[Medico] SET [nombre]='Antonella',[correo]='activa10/10.com'
UPDATE [dbo].[Medico] SET [nombre]='Johan valerio',[correo]='elllanoteama.com' WHERE [idMedico]=1

INSERT INTO [dbo].[Medico] ([nombre],[especialidad],[correo]) values ('angiee','industrial','meencantaelvisto')

DELETE FROM [dbo].[Medico] WHERE [nombre]='angiee' OR [correo]='aea'
UPDATE [dbo].[Medico] SET [idMedico]=3 WHERE [correo]='activa-10/10.com'

--USE Northwind
--SELECT TOP 10 * FROM dbo.Products

--SELECT TOP 7* FROM dbo.Customers  WHERE [PostalCode] LIKE '%8%' ORDER BY [CustomerID] ASC

--SELECT  TOP 1 [Region],[ContactName] FROM dbo.Customers
INSERT INTO [dbo].[Medico] ([nombre],[especialidad],[correo]) values('mark','desarrollador front end','facebokk@hotmail.com')

SELECT DISTINCT ([nombre]) FROM [dbo].[Medico]
SELECT [nombre] FROM [dbo].[Medico] GROUP BY [nombre]