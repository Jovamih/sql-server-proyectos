--SQL  con Inner Join
insert into [dbo].[MedicoEspecialidad] values(2,3,'Insteresante')
SELECT * FROM Especialidad
go
select * from [dbo].[Medico]
select * from [dbo].[MedicoEspecialidad]
go
select * from [dbo].[Medico] as M 
	RIGHT  JOIN [dbo].[MedicoEspecialidad] as E --INNER JOIN | LEFT JOIN | RIGHT JOIN
	ON M.idMedico= E.idMedico

--------------------------------
go
select * from [dbo].[Turno]
select * from [dbo].[Medico]
select * from [dbo].[MedicoEspecialidad]
select * from [dbo].[TurnoPaciente]
---
insert into [dbo].[Turno] values(1,'2020-12-12',1,'Casual')
insert into [dbo].[TurnoPaciente] values (1,2,12)
go
select * from [dbo].[Medico] as M
	INNER JOIN [dbo].[MedicoEspecialidad] as ME ON M.idMedico= ME.idMedico
	INNER JOIN [dbo].[TurnoPaciente] as TP ON ME.idMedico=TP.idMedico
-------------Uso de los Joins --> LEFT OUTER JOIN	| RIGHT OUTE JOIN	| FULL OUTER JOIN
