create database if not exists formacion;

use formacion;

drop table if exists matricula;
drop table if exists edicion;
drop table if exists prerequisito;
drop table if exists capacitado;
drop table if exists empleado;
drop table if exists curso;

create table if not exists curso(
	codCurso char(10) primary key,
	nombre char(30) unique,
	duracion smallint not null
);

create table if not exists empleado(
	codEmp char(10) primary key,
	nif char(10) unique,
	capacitado enum ('S' , 'N') not null
);

create table if not exists capacitado(
	capacitado char(10) primary key,

	foreign key (capacitado) references empleado (codEmp) on delete cascade on update cascade 
);

create table if not exists prerequisito(
	curso char(10),
	cursoReq char(10),
	obligatorio tinyint(1) not null,

	primary key(curso, cursoReq),
	foreign key (curso) references curso (codCurso) on delete restrict on update cascade,
	foreign key (cursoReq) references curso (codCurso) on delete restrict on update cascade
);

create table if not exists edicion(
	curso char(10),
	fecha date,
	lugar varchar(30) not null,
	horario enum ('m', 't', 'i') not null,
	profesor char(10),

	primary key (curso, fecha),
	foreign key (curso) references curso (codCurso) on delete cascade on update cascade,
	foreign key (profesor) references capacitado (capacitado) on delete restrict on update cascade
);
create table if not exists matricula(
	curso char(10),
	fechaMat date,
	empleado char(10),

	primary key(curso, fechaMat, empleado),
	foreign key (curso, fechaMat) references edicion (curso , fecha) on delete cascade on update cascade,
	foreign key (empleado) references empleado (codEmp) on delete restrict on update cascade
);

insert empleado (codEmp, nif, capacitado) values ('001','aaa', 's'), ('002', 'bbb', 'n'), ('003', 'ccc', 's'), ('004', 'ddd', 's'), ('005', 'eee', 'n'), ('666', 'ElDiablo', 's');

insert capacitado (capacitado) values ('001'), ('003'), ('004'), ('666');

insert curso (codCurso, nombre, duracion) values ('linux', 'Linux Básico', 100),('linux2', 'Linux Avanzado', 100),('unity', 'Unity Básico', 500),('unityAdv', 'Unity Avanzado', 1000),('cSharp', '.NET', 2000);

insert prerequisito (curso, cursoReq ,obligatorio) values ('linux2', 'linux', 1), ('unityAdv', 'unity', 1), ('cSharp' , 'linux', 0), ('unity', 'linux', 0);

insert edicion (curso, fecha, lugar, horario, profesor) values ('linux', '2012-01-20', 'Clase A', 'm', '001'),('linux2', '2013-01-20', 'Clase C', 'm', '001'), ('cSharp', '2015-03-01', 'Clase .NET', 'i', '666'), ('unity', '2014-02-25', 'Clase Unity', 't', '004'), ('unityAdv', '2015-09-15', 'Clase Unity', 'i', '004');

insert matricula (curso, fechaMat, empleado) values ('linux', '2012-01-20', '002'),('linux', '2012-01-20', '005')
,('linux2', '2013-01-20', '002'),('linux2', '2013-01-20', '005')
,('unity', '2014-02-25', '002'),('unity', '2014-02-25', '005')
,('unityAdv', '2015-09-15', '002'),('unityAdv', '2015-09-15', '005')
,('cSharp', '2015-03-01', '002'),('cSharp', '2015-03-01', '005');