--TRANSACTION
INSERT  INTO [dbo].[Medico] VALUES ('ANGELA','kodaline@234',22,1)
SELECT * FROM [dbo].[Medico]
PRINT IDENT_CURRENT('[dbo].[Especialidad]')
--SELECT*FROM [dbo].[Especialidad]
PRINT @@IDENTITY
PRINT IDENT_CURRENT ('[dbo].[Medico]')
print SCOPE_IDENTITY()
--RESEATEAR IDENTITY
DBCC CHECKIDENT ('[dbo].[Medico]',RESEED,12)
SELECT* FROM[dbo].[Historia]
GO
--SET NOCOUNT OFF
BEGIN TRANSACTION
	UPDATE [dbo].[Medico] SET idEspecialidad=3 WHERE nombre='mark'
	if @@rowcount=2
		COMMIT TRANSACTION
	ELSE
	begin
		ROLLBACK TRANSACTION
		print 'cambios desechos'
	end
GO
--delete from Medico where idMedico=12
begin tran
	BEGIN TRY
		--BEGIN TRAN
		INSERT INTO [dbo].[Medico] VALUES(12,332,'edad',88)
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		print 'se descartaron los cambios'
	END CATCH
if XACT_STATE()=1
begin
	print 'Transaccion valida'
	commit tran
	print 'transaccion cerrada'
end
else
	print 'Transaccion invalida'


PRINT 'UNA PALABRA'
--new id
print newid()
print newid()
declare @cant int=len(convert(varchar(100),newid()))
declare @id uniqueidentifier= newid()
print @id
if XACT_STATE()=1
	print 'Transaccion valida'
else
	print 'Transaccion invalida'
go
--TRANSACCIONES Y THE PRACTICE
CREATE PROCEDURE borrarMedico (@idMedico int)
	AS
BEGIN TRANSACTION
	BEGIN TRY
		