drop database if exists formacion;

create database if not exists formacion;

use formacion;

drop table if exists matricula;
drop table if exists edicion;
drop table if exists prerreq;
drop table if exists capacitado;
drop table if exists empleado;
drop table if exists curso;

create table curso (
	codCurso char(15),
	nombre varchar(25) unique not null,
	duracion smallint not null,

	primary key (codCurso)
);
create table empleado (
	codEmp char(5),
	nombre varchar(100) not null,
	nif char(8) unique not null,
	capacitado enum('S','N') not null,

	primary key (codEmp)
);


create table capacitado (
	codEmp char(5),

	primary key (codEmp),
	foreign key (codEmp) references empleado (codEmp) on update cascade on delete cascade
);

create table prerreq (
	curso char(15),
	cursoReq char(15),
	obligatorio tinyint(1) not null,

	primary key (curso, cursoReq),
	foreign key (curso) references curso (codCurso) on update cascade,
	foreign key (cursoReq) references curso (codCurso) on update cascade
);


create table edicion (
	codCurso char(15),
	fecha date not null,
	lugar char(10) not null,
	horario enum('M','T','I') not null,
	profesor char(5) not null,

	primary key (fecha, codCurso),
	foreign key (codCurso) references curso (codCurso) on delete cascade on update cascade,
	foreign key (profesor) references capacitado (codEmp) on update cascade
);

create table matricula (
	fecha date,
	curso char(15),
	empleado char(5),

	primary key (fecha, curso, empleado),
	foreign key (fecha, curso) references edicion (fecha, codCurso) on update cascade,
	foreign key (empleado) references empleado (codEmp) on update cascade
);


insert into empleado (codEmp, nombre, nif, capacitado) values ('001','emp 001','111F','N');
insert into empleado (codEmp, nombre, nif, capacitado) values ('002','emp 002','222A','S');
insert into empleado (codEmp, nombre, nif, capacitado) values ('003','emp 003','333N','S');
insert into empleado (codEmp, nombre, nif, capacitado) values ('004','emp 004','444R','N');

insert into capacitado (codEmp) values ('002'),('003');

insert into curso (codCurso, nombre, duracion) values ('linux','Linux básico', 100);
insert into curso (codCurso, nombre, duracion) values ('linux2','Linux Avanzado', 500);
insert into curso (codCurso, nombre, duracion) values ('unity','Unity básico', 1000);
insert into curso (codCurso, nombre, duracion) values ('unityAdv','Unity  Avanzado', 2000);
insert into curso (codCurso, nombre, duracion) values ('CSharp','CSharp básico', 1000);

insert into prerreq (curso, cursoReq, obligatorio) values ('linux2','linux',1);
insert into prerreq (curso, cursoReq, obligatorio) values ('unityAdv','linux2',1);
insert into prerreq (curso, cursoReq, obligatorio) values ('unityAdv','unity',0);
insert into prerreq (curso, cursoReq, obligatorio) values ('CSharp','linux',0);	