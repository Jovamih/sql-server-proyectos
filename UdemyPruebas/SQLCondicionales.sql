DECLARE @SALUDO VARCHAR(20);
SET @SALUDO='como estas';

declare @numero int =9;

--USO DE if
IF @SALUDO ='estas bien?'
	print 'es un buen saludo'
ELSE
begin
print 'no es un buen saludo'
end

if @numero IN(1,2,34,5)
print 'xd'
--ESTRUCTURA while
declare @numero int =0;
declare @suma int =0;
WHILE @numero<=45
	BEGIN
		print @numero
		SET @numero=@numero+1
		set @suma=@suma+@numero
		if @suma>100
		begin
				print 'La suma supero los 100'
				break
		end
	END
print 'La suma es '--+varchar(@suma)
print @suma
--return termina la aplicacion mientras el break cancela la ejecucion del codigo y continua el resto

--Sentencias CASE- WHEN- THEN
SELECT * FROM dbo.Usuario
GO
SELECT * ,(CASE WHEN [nombre] LIKE '%an%' THEN 'Contiene la AN'
				WHEN [nombre] LIKE '%[Ee]%' THEN 'Contiene la "e"'
				ELSE 'Incognito'
			END
) AS Caracteristica FROM [dbo].[Usuario]
go
--SUBCONSULTA
SELECT *,
	(ISNULL((SELECT [dni] FROM [dbo].[InformacionUsuario] AS U WHERE U.[idUsuario]= L.idUsuario),'NO ESPECIFICADO')) AS DNI
FROM [dbo].[Usuario] AS L
--USANDO CASE PARA ASIGNAR VALORES
declare @valor int =3;
PRINT @valor
set @valor = ( CASE WHEN (@valor BETWEEN 0 AND 4 )THEN 9
					WHEN( @valor between 5 and 9) THEN 7
				ELSE 8
				end
		)
PRINT @valor
--RETURN --BREAK
-- TRY -CATCH
declare @numero int= 67;
begin try
set @numero='hola'
end try
begin catch
	print 'No se puede asignar caracteres a una variaabe entera'
end catch