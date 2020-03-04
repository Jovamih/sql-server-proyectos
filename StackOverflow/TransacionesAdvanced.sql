go

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

GO
CREATE TABLE tabla1(
	id int identity primary key,
	descripcion varchar(50)
)
go
BEGIN TRANSACTION 
	insert into [dbo].[tabla1] ([descripcion]) values('VALOR EN 63636'),('Estado desconocido')

COMMIT TRANSACTION
BEGIN TRANSACTION
	delete from [dbo].[tabla1] where [descripcion] LIKE '%6'
	if @@rowcount >1
		ROLLBACK TRANSACTION
GO
--START
INSERT INTO [dbo].[tabla1] ([descripcion]) VALUES('transaccion 1'),('77635511')
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select* from [dbo].[tabla1]
go
CREATE PROCEDURE sp_state_transaction
as begin
			if xact_state() =1
				print 'transaccion en curso'
			else if XACT_STATE()=0
				print 'trasaccion cerrada'
			else
				print 'Transaccion interrumpida'
end 
EXECUTE sp_state_transaction
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
SELECT* FROM [dbo].[tabla1]
TRUNCATE TABLE [dbo].[tabla1]
go

print ASCII('O')
PRINT CHAR(65)
GO
SELECT U.* FROM OPENROWSET(BULK 'D:\User\CSCmd\Udemy\CrudDatabase\jsonfile.json',SINGLE_CLOB) AS J
				CROSS APPLY OPENJSON(BulkColumn) WITH(
				usuario varchar(20) '$.Usuario',
				PWD varchar(20) '$.PWD'
				) AS U
SELECT * FROM OPENJSON(@json)
go
declare @json nvarchar(max)=(select BulkColumn from OPENROWSET(BULK 'D:\User\CSCmd\Udemy\CrudDatabase\jsonfile.json' ,SINGLE_CLOB) as J)
select U.*from OPENJSON(@json) with(
    Usuario varchar(20) '$.Usuario'
) as U
