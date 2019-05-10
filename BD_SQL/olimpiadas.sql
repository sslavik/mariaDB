
/*
CAMPOS CALCULADOS
	En federación el num de federados se calcula automáticamente de los esquiadores que esten en esa federacion
	La edad del esquiador por su fecha de nacimiento
	En equipo el num de esquiadores contiene el número esquiadoresEquipo que hay con este equipo asociado.
*/

create database if not exists olimpiadas;
use olimpiadas

drop table if exists dorsalEquipo_esquiadorEquipo;
drop table if exists esquiadorEquipo;
drop table if exists esquiadorIndividual;
drop table if exists esquiador;
drop table if exists dorsalEquipo;
drop table if exists dorsalIndividual;
drop table if exists dorsal;
drop table if exists prueba_pista;
drop table if exists estacion_federacion;
drop table if exists puntosContacto;
drop table if exists formacionPistas;
drop table if exists pista;
drop table if exists federacion;
drop table if exists estacion;
drop table if exists equipo;
drop table if exists prueba;

create table prueba (
	nombrePrueba varchar(50) primary key
);

/*El nº de esquiadores un derivado */
create table equipo (
	nombre varchar(50) primary key,
	Nesquiadores int unsigned not null,
	entrenador varchar(50) not null
);

create table estacion (
	CodEstacion int unsigned primary key,
	nombre varchar(50)
);

create table federacion (
	nombre varchar(50) primary key,
	Nfederados int unsigned not null
);

create table pista (
	codEstacion int unsigned,
	Npista int unsigned,
	dificultad char(30) not null,
	longitud decimal unsigned not null,
	
	primary key (codEstacion,Npista),
	foreign key (codEstacion) references estacion (codEstacion) on update cascade on delete cascade
);

create table formacionPistas (
	codEstacionContenedora int unsigned,
	NpistaContenedora int unsigned,
	codEstacionContenida int unsigned,
	NpistaContenida int unsigned,
	
	primary key (codEstacionContenedora,NpistaContenedora,codEstacionContenida,NpistaContenida),
	foreign key (codEstacionContenedora,NpistaContenedora) references pista (codEstacion,Npista) on update cascade on delete restrict,
	foreign key (codEstacionContenida,NpistaContenida) references pista (codEstacion,Npista) on update cascade on delete restrict	
);

/*Multivaluado de estación*/
create table puntosContacto (
	codEstacion int unsigned,
	Pcontacto varchar(40),
	
	primary key (codEstacion,Pcontacto),
	foreign key (codEstacion) references estacion (codEstacion) on update cascade on delete cascade
);

create table estacion_federacion (
	nombreFederacion varchar(50),
	estacion int unsigned,
	
	primary key(nombreFederacion,estacion),
	foreign key (nombreFederacion) references federacion (nombre) on update cascade on delete restrict,
	foreign key (estacion) references estacion (codEstacion) on update cascade on delete restrict
);

create table prueba_pista (
	nombrePrueba varchar(50),
	codEstacion int unsigned,
	Npista int unsigned,
	jornada varchar(50),
	
	primary key (nombrePrueba,codEstacion,Npista,jornada),
	foreign key (nombrePrueba) references prueba (nombrePrueba) on update cascade on delete restrict,
	foreign key (codEstacion,Npista) references pista (codEstacion,Npista) on update cascade on delete restrict
);

/*AQUI ESTA LA PRIEMRA JERARQUIA DE DORSAL*/
create table dorsal (
	nombrePrueba varchar(50),
	codDorsal int unsigned,
	
	primary key (nombrePrueba,codDorsal),
	foreign key (nombrePrueba) references prueba (nombrePrueba) on update cascade on delete cascade
);

create table dorsalIndividual (
	nombrePrueba varchar(50),
	codDorsal int unsigned,
	
	primary key(nombrePrueba,codDorsal),
	foreign key(nombrePrueba,codDorsal) references dorsal (nombrePrueba,codDorsal) on update cascade on delete cascade
);

create table dorsalEquipo (
	nombrePrueba varchar(50),
	codDorsal int unsigned,
	
	primary key(nombrePrueba,codDorsal),
	foreign key(nombrePrueba,codDorsal) references dorsal (nombrePrueba,codDorsal) on update cascade on delete cascade
);

/*AQUI LA SEGUNDA JERARQUIA DE ESQUIADOR*/
create table esquiador (
	dni char(9) primary key,
	nombre varchar(50) not null,
	Fnacimiento date not null,
	edad int unsigned not null,
	federado varchar(50) not null,
	
	foreign key (federado) references federacion (nombre) on update cascade on delete restrict
);

create table esquiadorIndividual (
	dni char(9) primary key,
	
	foreign key (dni) references esquiador (dni) on update cascade on delete cascade
);

create table esquiadorEquipo (
	dni char(9) primary key,
	equipo varchar(50) not null,
	
	foreign key (dni) references esquiador (dni) on update cascade on delete cascade,
	foreign key (equipo) references equipo (nombre) on update cascade on delete restrict
);
/*-----------------------------------------------------------------------------------*/

create table dorsalEquipo_esquiadorEquipo (
	nombrePrueba varchar(50),
	codDorsal int unsigned,
	dni char(9),
	
	primary key (nombrePrueba,codDorsal,dni),
	foreign key (dni) references esquiadorEquipo (dni) on update cascade on delete restrict,
	foreign key (nombrePrueba,codDorsal) references dorsalEquipo (nombrePrueba,codDorsal) on update cascade on delete restrict
);
