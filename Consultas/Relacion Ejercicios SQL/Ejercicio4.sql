/* VYACHESLAV SHYLYAYEV
Ejercicio 4. Dadas las siguientes tablas relacionales:
    Cigarrillo (#marca, #filtro, nombre_fabricante, precio)     
    Estanco (#CIF, nombre, dirección)     
    Fabricante (#nombre, pais)     
    Compras (#CIF, #marca, #filtro, año, cantidad, precio)     
    Ventas (#CIF, #marca, #filtro, año, cantidad, precio)
Plantear las siguientes preguntas utilizando SQL:
*/
drop database if exists estanco;
create database if not exists estanco;

use estanco;

drop table if exists venta;
drop table if exists compra;
drop table if exists cigarrillo;
drop table if exists estanco;
drop table if exists fabricante;


create table if not exists estanco (
    CIF char(15) primary key, 
    nombre char(100) not null,
    direccion char(80) not null
);

create table if not exists fabricante (
    nombre char(50) primary key,
    pais char(100) not null
);

create table if not exists cigarrillo (
    marca varchar(100),
    filtro enum ('s','n','r') not null,
    nombre_fabricante char(50),
    precio float not null,

    primary key (marca, filtro),
    foreign key (nombre_fabricante) references fabricante (nombre) on delete restrict on update cascade
);

create table if not exists compra (
    CIF char(15), 
    marca varchar(100), 
    filtro enum ('s','n','r') not null,
    anio date not null,
    cantidad integer not null,
    precio float not null,

    primary key (CIF, marca, filtro),
    foreign key (CIF) references estanco (CIF) on delete restrict on update cascade,
    foreign key (marca, filtro) references cigarrillo (marca, filtro) on delete restrict on update cascade
);

create table if not exists venta (
    CIF char(15), 
    marca varchar(100), 
    filtro enum ('s','n','r') not null,
    anio date not null,
    cantidad integer not null,
    precio float not null,

    primary key (CIF, marca, filtro),
    foreign key (CIF) references estanco (CIF) on delete restrict on update cascade,
    foreign key (marca, filtro) references cigarrillo (marca, filtro) on delete restrict on update cascade
);
-- 1. Obtener todas las marcas de cigarrillos extranjeros.       
select marca from cigarrillo where nombre_fabricante in (select nombre from fabricante where nombre != 'ESPAÑA');
-- 2. Obtener el total de compras de cigarrillos con filtro (filtro = “S”) realizadas por marca.      
select count(*) from compra where filtro = 'S' group by marca; 
-- 3. Obtener una relación completa de todas las compras y ventas realizadas.     
select * from compra union venta;  
-- 4. Obtener la relación de estancos que no han vendido cigarrillos “Ducados” con filtro.
select e.* from estanco e join venta v on (v.CIF = e.CIF) where v.nombre != "Ducados" and v.filtro = 'n';