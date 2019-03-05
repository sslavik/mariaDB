create database if not exists empresa;

use empresa;

drop table if exists empleado;
drop table if exists domicilio;
drop table if exists departamento;

create table if not exists departamento(
    codigo integer primary key,
    nombre varchar(255),
    presupuesto DOUBLE(10,2) zerofill
);

create table if not exists domicilio(
    id integer primary key,
    dir varchar (255),
    num varchar (100),
    poblacion varchar (255),
    codPostal char(5)
);

create table if not exists empleado(
    numEmp integer primary key, 
    dni char(20) unique,
    nombre varchar(255),
    telefono char(30),
    sueldo double(10,2) zerofill,
    fechaIngreso date,
    depart integer,
    domicilio integer,

    foreign key (depart) references departamento (codigo) on delete restrict on update cascade,
    foreign key (domicilio) references domicilio (id) on delete restrict on update cascade
);