create database StackOverflow 
use Stackoverflow
go

create table users(
	idUser int identity(1,1) ,
	nombre varchar(20) not null,
	pwd varchar(20) masked with (function='email()')  check(LEN(pwd)>8),
	constraint PK_idUser_users PRIMARY KEY(idUser)
)
go

select current_user as Usuario
GO
GRANT UNMASK TO angie
EXECUTE AS USER ='angie'
deny unmask to angie
execute as user='dbo'
go
insert into users(nombre,pwd) values('johan','kodalineEP')
select * from users
go

alter table users
		alter column pwd drop masked
go
alter table users
		alter column pwd ADD MASKED WITH(FUNCTION='default()')
go
execute as user ='dbo'







