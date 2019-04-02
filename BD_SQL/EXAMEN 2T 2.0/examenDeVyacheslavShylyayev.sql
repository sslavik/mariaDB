-- 1
--[CONSOLA]
mysql -u root
--[MARIADB]
update mysql.user set plugin = "";
--[CONSOLA]
mysql_secure_installation
-- UNA VEZ DENTRO SEGUIREMOS LOS PASOS Y PONDREMOS '123' COMO CONTRASEÑA
-- POR ULTIMO
systemctl restart mysql.service;

--2
create database exdvd;

use exdvd;

alter database character set utf8mb4;

drop table if exists pais;
drop table if exists dvd;

create table if not exists dvd (
	codigo int primary key,
	titulo varchar(100),
	artista varchar(100),
	pais char(2),
	compania varchar(50),
	precio decimal(10,2),
	anio date
) engine = innoDB ;

alter table dvd character set utf8mb4;

create table if not exists pais (
	nombre varchar(100),
	name varchar(100),
	nom varchar(100),
	iso2 char(2),
	iso3 char(3),
	phone_code char(5)
) engine = innoDB;

alter table pais character set utf8mb4;

--3
-- [CONSOLA]
iconv -f iso-8859-1 -t utf8 pais.csv > paisUTF8.csv
iconv -f us-ascci -t utf8 dvd.csv > dvdUTF8.csv -- 
-- [MARIADB]
load data local infile '/home/alumno1718/Escritorio/paisUTF8.csv' into table pais fields terminated by '*' ignore 6 lines;
load data local infile '/home/alumno1718/Escritorio/dvdUTF8.csv' into table dvd fields terminated by ';' ignore 5 lines;

--4
grant select, update, delete, insert on exdvd.* to operador@'%' identified by 'op123';

--5
grant file on *.* to operador;

--6
revoke delete on exdvd.* from operador; 

--7
create table if not exists t1(id int, nombre char(100), fNac date, sueldo decimal(8,2));
grant select(id,nombre) on exdvd.t1 to operador;
revoke update, insert on exdvd.* from operador;
grant update, insert on exdvd.dvd to operador;
grant update, insert on exdvd.pais to operador;
--8
set password for operador@'%' = password('op2019');
--9
revoke all, grant option from vendedor@'%';
--10
show grants;
--11
--a)[CONSOLA 1] mysql -u root -p exdvd
begin;
select * from t1 where sueldo between 500 and 1000 for update;
update t1 set sueldo = sueldo * 1.10 where sueldo between 500 and 1000;
--b)[CONSOLA 2] mysql -u root -p exdvd
begin;
select * from t1 where sueldo between 300 and 499 lock in share mode;
create table t2 (select * from t1 where sueldo between 300 and 499);
commit;
--[CONSOLA1]
commit;
/*c) No existe bloqueo ninguno porque la sesion 1 (CONSOLA 1) hace una intencion de escritura en las filas que cumplan la condicion : 
	"where sueldo between 500 and 1000 for update;"
	Por lo que si la sesión 2 (CONSOLA 2) hace una intencion de lectura y bloqueando la escritura con LOCK IN SHARE MODE de las filas 
	que cumplen la condicion :
	"where sueldo between 300 and 499 lock in share mode;"
	las 2 condiciones afectan a distintas filas aunque tengan intenciones distintas sobre la misma tabla.
*/

--12
create table if not exists t3 (
	valor int
) engine = innoDB; 
insert into t3 values (0);

--[CONSOLA 1] mysql -u root -p exdvd
begin;
select * from t3 for update;
update t3 set valor = valor + 1;
commit;
--[CONSOLA 2] mysql -u root -p exdvd
begin;
select * from t3 for update;
update t3 set valor = valor + 1;
commit;


--13
select @@global.tx_isolation;
/*
Con el comando anterior podremos ver la configuración del aislamiento en las transacciones globales. Por defecto el aislamiento es de "REPEATABLE-READ"
Lo que nos informa de que si una sesion X comienza una transaccion (BEGIN;) los datos que van a leer siempre serán los mismos desde que empezó
aquella transacción. Al igual que la modificación afectará a los mismos datos que tenia al iniciar la transaccion (BEGIN;). Y estos datos siempre
serán verdad hasta que la transaccion termine con un (COMMIT || ROLLBACK), Donde los datos se actualizarán con los que puedan haber nuevos o incluso
sobre-escribirlos.

Algo a tener en cuenta es que el aislamiento (@@tx_isolation) solo se tiene en cuenta cuando el "autocommit = 0". en caso contrarío todo aquellas
modificaciones o lecturas serán de una base de datos actualizada.

EJEMPLO :

Supongamos que una SESION 1 :
BEGIN;
select * from t; -- Esta lectura será de los datos que habia justo cuando se hizo el BEGIN; ¿POR QUÉ?
Supongamos que una SESION 2 :
insert into t values (1,null); -- Esto al no estar en transacción se hará el autocommit y se guardará en la tabla
PERO si miramos la SESION 1 :
select * from t; veremos que tiene los mismos datos ( NO ESTA EL "(1,null)" de SESION 2).
Esto es por el aislamiento "REPEATABLE-READ" 
UNA VEZ haga un COMMIT la SESION 1. verá los nuevos datos insertados además de que los datos que insertó SESION 1 pueden sobre escribir
los que habia antes o dar un error si la clave primaria es igual.
*/ 

--14
set global transaction isolation level READ COMMITTED; -- PARA CAMBIAR DE AISLAMIENTO
/*
Con el nivel de aislamiento "READ-COMMITTED" nos permite que cuando inicialicemos una transaccion (BEGIN) en una SESION X siempre leera todo
aquello que esta "COMMITED" que esta realmente en la BASE DE DATOS. Por lo que si ahora una SESION Y inserta nuevos datos en la base de datos 
y la SESION X hace una lectura verá que los datos han cambiado. PORQUE la SESION Y ha insertado datos de forma definitiva al hacerlo con "autocommit = 1"

De tal manera que todas las sesiones que tengan el aislamiento en READ COMMITTED verán todas las modifiaciones y trabajaran siempre con una base
de datos consolidada (SIN LECTURAS SUCIAS).
*/
