SELECT MAX([especialidad]) FROM [dbo].[Medico]
SELECT * FROM [dbo].[Medico] ORDER BY [especialidad] DESC
SELECT TOP 3 * FROM [dbo].[Medico] order by[idMedico] ASC

--FUNCIONES DE AGREGADO
--MAX Y MIN()
-- SUM
SELECT [idMedico] from [dbo].[Medico]
SELECT SUM([idMedico]) FROM [dbo].[Medico]

SELECT nombre ,SUM([Edad]) FROM [dbo].[Medico] group by[nombre]

SELECT nombre ,AVG([Edad]) FROM [dbo].[Medico] group by nombre
SELECT SUM(edad) FROM [dbo].[Medico] where nombre like '%[rR]%'
select * from dbo.Medico
--metodos extras
--COUNT SE usa en conjunto con HAVING

SELECT COUNT([idMedico])  FROM dbo.Medico WHERE [nombre] LIKE '%a%' --group by nombre

--having usando
SELECT nombre FROM [dbo].[Medico] ORDER BY nombre HAVING