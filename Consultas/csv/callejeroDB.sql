drop database if exists callejero;

create database if not exists callejero;

use callejero;

drop table if exists calles;
drop table if exists localidades;
drop table if exists provincias;

create table if not exists provincias(
    codProvincia char(2),
    nomProvincia varchar(100)
) engine = MyISAM;

create table if not exists localidades(
    codigo integer,
    codProvincia char(2),
    codPostal char(5),
    nombreLocalidad varchar(255)
) engine = MyISAM;

create table if not exists calles(
    codigo integer,
    codPostal char(5),
    nomCalle varchar(255)
) engine = MyISAM;