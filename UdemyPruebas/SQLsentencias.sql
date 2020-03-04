USE Life
CREATE FUNCTION Suma(@valor1 int , @valor2 int)
RETURNS int
AS

BEGIN
	DECLARE @valor int=0;
	SET @valor=@valor1+@valor2;
RETURN @valor;
END
GO

dbo.Suma 12,23
SELECT dbo.Suma(12,23) as Resultado

--FUNCIONES DE CONVERSION

go
DECLARE @nombre varchar(30)='JOHAN';
declare @apellido varchar(30)='VALERIO'
--LEFT y RIGTH
declare @clave varchar(10);
declare @clave2 varchar(10);
SET @clave =LEFT(@nombre,2)+LEFT(@apellido,2);
set @clave2= RIGHT(@nombre,3)+RIGHT(@apellido,3);

--LEN(caracter)
print @clave+convert(varchar(3),LEN(@clave))
print @clave2+ STR(LEN(@clave2))

--funciones LOWER and UPPER
declare @palabra varchar(20);
set @palabra='Johan Valerio'
declare @palabra2 varchar(20)='JohAn VAlerIo';

print UPPER(@palabra)
print LOWER(@palabra)
if UPPER(@palabra) = UPPER(@palabra2)
	print 'Son iguales'
else
	print 'son diferentes'

go
--replace function
declare @letra varchar(40)='jo@an valerio mitma @uacc@a';
print replace(@letra,'@','h')
--REPLICATE funcion --> PRELICATE (caracteres,n_veces)
PRINT REPLICATE('HOLA',8)
--LTRIM and LTRIM funciones -->elimina espacios en blanco de los lados LEFT or RIGHT==>trim(LOS DOS)
PRINT TRIM('         HOLA         8        ')
print LTRIM('                                 como estas 9 ')
print RTRIM ('               HOLA 2           ')+'v'
go
--CONCAT --> Para concatenar 2 cadenas
declare @letra varchar(10)='hola ';
declare @letra2 varchar(10)=' como estas'

select CONCAT(@letra,@letra2) as Concatenado
go
--FUNCIONES GETDATE() Y GETUTCDATE
select getdate() as Fecha,GETUTCDATE() as FechaUTC