create database if not exists ajedrez character set = utf8mb4;
use ajedrez;

drop table if exists movimiento;
drop table if exists aloja;
drop table if exists partida;
drop table if exists jugador;
drop table if exists arbitro;
drop table if exists participante;
drop table if exists pais;
drop table if exists medios;
drop table if exists sala;
drop table if exists hotel;

create table hotel(
    nombre char(20),
    direccion varchar(20) not null unique,
    telefono varchar(15) not null unique,
    primary key(nombre)
);

create table sala(
    codS char(3),
    capacidad smallint(3) unsigned not null,

    primary key (codS)
);

create table medios(
    sala char(3),
    nomMedio varchar(20),

    primary key (sala, nomMedio),

    foreign key (sala) references sala (codS) on update cascade on delete cascade
);

create table pais (
    pais char(2) primary key,
    nombre varchar(20) unique not null,
    nClubes smallint unsigned not null,
    representante char(2) null,

    foreign key (representante) references pais (pais) on update cascade on delete restrict 
);

create table participante (
    nSocio char(5) primary key,
    nombre varchar(30) not null,
    direccion varchar(40) not null,
    telefono varchar(15) not null,
    pais char(2) not null,
    campeonatos varchar(300) null,
    tipo enum ('J', 'A') not null,
    
    foreign key (pais) references pais (pais) on update cascade on delete restrict
);

create table arbitro (
    nSocio char(5) primary key,

    foreign key (nSocio) references participante (nSocio) on update cascade on delete cascade
);

create table jugador (
    nSocio char(5) primary key,
    nivel enum ('1', '2','3','4','5') not null,

    foreign key (nSocio) references participante (nSocio) on update cascade on delete cascade
);

create table partida(
    codP char(3),
    sala char(3) not null,
    entradasVendidas smallint unsigned default 0 not null,
    jornada date not null,
	jugadorBlancas char(5) not null,
	jugadorNegras char(5) not null,
	arbitro char(5) not null,
    primary key (codP),
    foreign key `fk_sala` (sala) references sala (codS) on update cascade on delete restrict,
    foreign key (jugadorBlancas) references jugador (nSocio) on update cascade on delete restrict,
    foreign key (jugadorNegras) references jugador (nSocio) on update cascade on delete restrict,
    foreign key (arbitro) references arbitro (nSocio) on update cascade on delete restrict
);

create table aloja(
    nSocio char(5),
    fechaEntrada date,
    nombreHotel char(20),
    fechaSalida date null,
    
    primary key (fechaEntrada, nSocio, nombreHotel),
    foreign key (nSocio) references participante (nSocio) on update cascade on delete restrict,
    foreign key (nombreHotel) references hotel (nombre) on update cascade on delete restrict
);

create table movimiento(
	partida char(3),
	numMovimiento smallint unsigned,
    movimiento char(5) not null,
    comentario varchar(100) not null,
	primary key (partida, numMovimiento),
	foreign key (partida) references partida (codP) on update cascade on delete cascade
);


