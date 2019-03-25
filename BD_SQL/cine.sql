create database if not exists cine;

use cine;

drop table if exists pago;
drop table if exists sala;

create table if not exists sala(
    butaca integer primary key,
    estado enum('l','r','p') not null default 'l',
    idPago int null
) engine = MyISAM;

create table if not exists pago(
    id int not null auto_increment primary key,
    fecha timestamp not null,
    idCliente char(5),
    cantidad decimal(6,2)
) engine = MyISAM;

insert into sala (butaca) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);