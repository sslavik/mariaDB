create database if not exists padron;

use padron;

drop table if exists propietario;
drop table if exists habitante;
drop table if exists vivienda;
drop table if exists municipio;

create table if not exists municipio(
	codigo char(10) primary key,
	nombre varchar(50) not null
);

create table if not exists vivienda(
	nrc char(20) primary key,
	direccion varchar(50) not null,
	municipio char(10) not null,
	foreign key (municipio) references municipio (codigo) 
		on delete restrict
		on update cascade 
);

create table if not exists habitante(
	id char(10) primary key,
	nombre varchar(50) not null,
	empadronado char(10) not null,
	habita char(20) not null,
	cf char(10) null,
	foreign key (empadronado) references municipio (codigo) 
		on delete restrict
		on update cascade,
	foreign key (habita) references vivienda (nrc)
		on delete restrict
		on update cascade,
	foreign key (cf) references habitante (id)
		on delete restrict
		on update cascade
); 

create table if not exists propietario(
	habitante char(10),
	vivienda char(20),
	primary key (habitante, vivienda),
	foreign key (habitante) references habitante (id)
		on delete restrict
		on update cascade,
	foreign key (vivienda) references vivienda (nrc)
		on delete restrict
		on update cascade
);

-- Inserciones

insert into municipio (codigo, nombre) values ('29620', 'Torremolinos');
insert into municipio (codigo, nombre) values ('29010', 'Teatinos');
insert into municipio (codigo, nombre) values ('29012', 'Málaga Este');
insert into municipio (codigo, nombre) values ('29011', 'Málaga Centro');
insert municipio (codigo, nombre) values ('29006', 'Portada Alta'), ('29007', 'Cruz Humilladero'), ('29008', 'La Union');

insert vivienda (nrc, direccion, municipio) values ('111', 'Av Dirección 111', '29010');
insert vivienda (nrc, direccion, municipio) values ('112', 'Av Dirección 112', '29007');
insert vivienda (nrc, direccion, municipio) values ('113', 'Av Dirección 113', '29008');

insert habitante (id, nombre, empadronado, habita, cf) values ('001','Hab 001', '29007', '111' , null); -- Me permite directamente depender de sí mismo sin error
insert habitante (id, nombre, empadronado, habita, cf) values ('002','Hab 002 hijo de 001', '29010', '111' , '001');
insert habitante (id, nombre, empadronado, habita, cf) values ('003','Hab 003 hijo de 001', '29007', '111' , '001');
insert habitante (id, nombre, empadronado, habita, cf) values ('004','Hab 004', '29008', '112' , '004'); -- Me permite directamente depender de sí mismo sin error


insert propietario (vivienda, habitante) values ('111', '001');
insert propietario (vivienda, habitante) values ('111', '002');
insert propietario (vivienda, habitante) values ('111', '003');
insert propietario (vivienda, habitante) values ('112', '004');
-- Actualizaciones

update municipio set nombre = upper(nombre); 
update municipio set codigo = '29004' where codigo = '29007';

-- Borrado

delete from municipio; -- NO SE BORRA PORQUE EXISTE UNA DEPENDENCIA REFERENCIADA EN VIVIENDA