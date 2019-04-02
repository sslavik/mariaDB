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
	anio char(4)
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
