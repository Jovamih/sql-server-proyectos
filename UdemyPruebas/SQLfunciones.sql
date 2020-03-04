CREATE FUNCTION Potencia(@numero int,@potencia int)
	RETURNS INT
as

begin
	declare @resultado int =1;
	declare @count int=0;
	while @count < @potencia
		BEGIN
		set @resultado= @resultado*@numero;
		set @count= @count +1;
		END
	return @resultado;
end
go
select dbo.Potencia (12,4 ) as Resultado
Potencia 12,4

--FUNCIONES---->Obtener Pais
CREATE FUNCTION obtenerPais(@idPaciente int)
	returns varchar(20)
as
	begin
	declare @nombre varchar(20)
	set @nombre =(select pa.nombre from Paciente AS P	
					INNER JOIN Pais as pa ON pa.idPais= P.idPais
				   where idPaciente= @idPaciente
					)

	return @nombre;
	end
go
select dbo.obtenerPais(3) as Pais
go
--funciones de Tipo Escalar
--funciones de Tipo Tabla
SELECT *FROM Usuario
SELECT*FROM [dbo].[InformacionUsuario]
go
CREATE FUNCTION usersUnregistered()
	returns @user Table 
	( idUsuario int,
	  nombre varchar(20),
	 pass varchar(20))					 
as
begin
	INSERT @user
		SELECT U.idUsuario,U.nombre,U.pass FROM [dbo].[Usuario] as U
				LEFT JOIN [dbo].[InformacionUsuario] AS I
				ON I.idUsuario=U.idUsuario
		WHERE I.idUsuario IS NULL
	return
end;
go
exec [dbo].[sp_agregarInformacionUsuario] 5,'angie abanto',18,'74895632',2
if not exists(select * from [dbo].[usersUnregistered]())
	print 'todos los usuarios ya se registraron-->OK'
else
	--select * from [dbo].[usersUnregistered]()
	print 'faltan registrase usuarios'
go
declare @count int =0;
set @count = (select count(*) FROM [dbo].[usersUnregistered]() )
print @count

select *from sys.schemas
