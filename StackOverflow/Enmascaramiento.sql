
use StackOverflow
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
insert into users(nombre,pwd) values('angie','abanto27887')
select * from users
go

alter table users
		alter column pwd drop masked
go
alter table users
		alter column pwd ADD MASKED WITH(FUNCTION='default()')
go
execute as user ='dbo'
alter table users
			alter column pwd DROP MASKED;
ALTER TABLE users
			alter column pwd ADD MASKED WITH (FUNCTION='partial(2,"xxxxxxxxxx",1)')
go
--LEARNING AS
--AGREGAR MASCARAS --> column_name type MASKED WITH(FUNCTION ='[email(),default(),partial(begin,"struct",ending)]')
--ALTERAR TABLA PARA LAS MASCARAS---> ALTER TABLE myTable ALTER COLUMN nyColumn ADD MASKED WITH(FUNCTION='(list_function)')
--ELIMINAR MASCARAS----> ALTER TABLE myTable ALTER COLUMN myColumn DROP MASKED
--- 
---agregar usuaris para masked
----> GRANT UNMASK TO [user]
----> REVOKE UNMASK TO [user]

