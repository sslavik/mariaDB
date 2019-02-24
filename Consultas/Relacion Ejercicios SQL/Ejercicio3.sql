/* VYACHESLAV SHYLYAYEV 
Ejercicio 3. Dadas las siguientes tablas, dar una expresión SQL para cada una de las siguientes consultas:
    Vive (#nombre, calle, ciudad)     
    Trabaja (#nombre, #compañia, salario)     
    Situada (#compañia, ciudad)     
    Dirige (#nombre, #nombre_director)

drop database if exists empleados;
create database if not exists empleados;

use empleados;

drop table if exists dirige;
drop table if exists trabaja;
drop table if exists situada;
drop table if exists vive;

create table if not exists vive (
    nombre varchar(100) primary key,
    calle char(80) not null,
    ciudad varchar (100) not null
);

create table if not exists situada (
    compania char (20) primary key,
    ciudad varchar (100) not null
);

create table if not exists trabaja (
    nombre varchar(100),
    compania char(20),
    salario float not null,

    primary key (nombre, compania),
    foreign key (nombre) references vive (nombre) on delete restrict,
    foreign key (compania) references situada (compania) on delete restrict
);

create table if not exists dirige (
    nombre varchar(100),
    nombre_director varchar(100),

    primary key (nombre, nombre_director),
    foreign key (nombre) references vive (nombre) on delete restrict,
    foreign key (nombre_director) references vive (nombre) on delete restrict
);
*/
-- 1. Encontrar el nombre y la ciudad de todos los empleados que traba jan en El Corte Inglés.       
select nombre, ciudad from vive e where exists (
    select * from trabaja t where e.nombre = t.nombre and t.compania = 'ECI' 
);
-- 2. Encontrar todos los empleados que viven en la misma ciudad que la compañía en la que traba jan.     
select * from vive v where exists (
    select * from trabaja t where t.nombre = v.nombre and v.ciudad in (
        select ciudad from situada
    )
);  
-- 3. Encontrar el salario y la compañía de todos los directores.       
select t.salario, t.compania from trabaja t where exists (
    select * from dirige d where d.nombre = t.nombre
);
-- 4. Encontrar a todos los empleados que viven en la misma ciudad y en la misma calle que su director.
select * from dirige d join vive v using (nombre)
    where v.ciudad in (select ciudad from vive v2 where exists(
        select * from dirige d2 where d2.nombre_director = v2.nombre
    )
);