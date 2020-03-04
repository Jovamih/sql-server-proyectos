
SELECT PP.*,PW.PasswordHash FROM [Person].[Person] AS PP
	INNER JOIN [Person].[Password] AS PW	ON PP.BusinessEntityID=PW.BusinessEntityID

GO
BEGIN TRANSACTION
MERGE INTO [Person].[Password] AS Destinity
	USING(SELECT BusinessEntityID,ModifiedDate FROM [Person].[Person]) AS DataSource
ON Destinity.BusinessEntityID=DataSource.BusinessEntityID
WHEN MATCHED THEN 
		UPDATE SET Destinity.PasswordHash=getdate()
WHEN NOT MATCHED BY TARGET THEN
		INSERT () VALUES()
WHEN NOT MATCHED BY SOURCE THEN
		DELETE 
END
go
CREATE TABLE #temporaryTransaction(
	nombre nvarchar(30),
	accion nvarchar(30)
)
GO
BEGIN TRANSACTION
MERGE [dbo].[Paciente] AS Paciente
	USING [dbo].[Medico] as Medico
	ON Medico.idMedico=Paciente.idPaciente
WHEN MATCHED THEN
		UPDATE SET Paciente.nombre=Medico.nombre
WHEN NOT MATCHED BY TARGET THEN
		INSERT (nombre,email,observacion,dni,idpais) VALUES(Medico.nombre,Medico.correo,TRY_CAST (Medico.idEspecialidad AS VARCHAR),rand(),Medico.idEspecialidad)
WHEN NOT MATCHED BY SOURCE THEN
		DELETE
OUTPUT inserted.nombre,$action into #temporaryTransaction;
--output deleted.nombre,$action INTO #temporaryTransaction;
--OUTPUT deleted.nombre,$action into #temporaryTransaction;
select*from #temporaryTransaction;
ROLLBACK TRANSACTION

PRINT EOMONTH(getdate())
PRINT DATEPART(DAY,GETDATE())
PRINT DATEPART(DAY,EOMONTH(getdate()))
go

