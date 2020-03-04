
--OPERADORES ARITMETICOS
declare @numero1 int=30
declare @numero2 int=6653
declare @result int

set @result= @numero2%@numero1

print @result

declare @palabra1 varchar(20)='HOLA COMO ESTAS?'
declare @palabra2 varchar(20)
declare @result1 varchar(40)

set @result1= ISNULL(@palabra1,'VACIO')+' '+ ISNULL(@palabra2,'VACIO')

print @result1

--OPERADORES BOOLEANOS

declare @var1 int =100
declare @var2 int =67

if @var1 <> @var2
	BEGIN
	
	print 'Son diferentes'
	if @var1> @var2
		print ltrim(STR(@var1)) +' es mayor que '+ltrim(STR(@var2))
	else
		print  convert(varchar(2),@var1) +' es menor que '+ convert(varchar(2),@var2)
	END
else
	print 'son iguales'