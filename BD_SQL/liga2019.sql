create database if not exists liga character set = utf8mb4;

use liga;

SET FOREIGN_KEY_CHECKS=0; -- TOMAMOS LA DECISION DE DESACTIVAR LAS CLAVES

drop table if exists equipo;
drop table if exists jugador;
drop table if exists partido;

create table equipo(
	id smallint,
	nombre varchar(25) not null,
	ciudad varchar(50) not null,
	web_oficial varchar(255),
	puntos smallint,
    capitan smallint null,

    primary key (id),
    foreign key `fk_capitan` (capitan) references jugador (id) on update cascade
);


create table jugador(
	id smallint,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	altura decimal(3,2),
	puesto varchar(50),
	fecha_alta date,
	salario int default 0,
	equipo smallint,

    primary key (id),
	foreign key (equipo) references equipo (id) on delete restrict on update cascade
);



create table partido(
    fecha date not null,	
    elocal smallint,
	evisitante smallint,
	resultado char(7) null,

	primary key (fecha, elocal, evisitante),
    foreign key (elocal) references equipo (id) on update cascade,
    foreign key (evisitante) references equipo (id) on update cascade
);

SET FOREIGN_KEY_CHECKS=1;



insert into equipo values (1,"Regal Barcelona","Barcelona","www.fcbarcelona.es/baloncesto",10,null);
insert into equipo values (2,"Real Madrid","Madrid","https://www.realmadrid.com/baloncesto",19,null);
insert into equipo values (3,"P.E. Valencia","Valencia","https://valenciabasket.com",11,null);
insert into equipo values (4,"Caja Laboral","Vitoria","https://www.baskonia.com/es",22,null);
insert into equipo values (5,"Gran Canaria","Las Palmas","https://www.cbgrancanaria.net",14,null);
insert into equipo values (6,"CAI Zaragoza","Zaragoza","https://www.basketzaragoza.net",23,null);
insert into equipo values (7,"Unicaja Baloncesto","Málaga","https://www.unicajabaloncesto.com/",24,null);

insert into jugador values (1,"Juan Carlos","Navarro",1.91,"Escolta","2010-01-10",130000,1);
insert into jugador values (2,"Felipe","Reyes",2.04,"Ala-Pivot","2009-02-20",120000,2);
insert into jugador values (3,"Victor","Claver",2.08,"Alero","2009-03-08",90000,3);
insert into jugador values (4,"Rafa","Martinez",1.91,"Escolta","2010-11-11",51000,3);
insert into jugador values (5,"Fernando","San Emeterio",1.99,"Alero","2008-09-22",130000,4);
insert into jugador values (6,"Mirza","Teletovic",2.06,"Pivot","2010-05-13",60000,4);
insert into jugador values (7,"Sergio","Llull",1.90,"Base-Escolta","2011-10-29",70000,2);
insert into jugador values (8,"Victor","Sada",1.92,"Base","2012-01-01",100000,1);
insert into jugador values (9,"Rudy","Fernández",2.03,"Alero","2010-02-19",180000,2);
insert into jugador values (10,"Xavi","Rey",2.09,"Pivot","2011-10-12",95000,5);
insert into jugador values (11,"Carlos","Cabezas",1.86,"Base","2008-01-21",105000,6);
insert into jugador values (12,"Pablo","Aguilar",2.03,"Alero","2012-06-14",47000,6);
insert into jugador values (13,"Rafa","Hettsheimer",2.08,"Pivot","2011-04-15",53000,6);
insert into jugador values (14,"Sitapha","Savané",2.01,"Pivot","2011-07-27",60000,5);
insert into jugador values (15,"Carlos","Suárez",2.03,"Ala-Pivot","2011-07-27",162000,7);
insert into jugador values (16,"Alberto","Díaz ",1.88,"Base","2012-04-26",60000,7);
insert into jugador values (17,"Ray","McCallum",1.90,"Base","2010-08-27",50000,7);
insert into jugador values (18,"James","Agustine",2.08,"Pivot","2017-10-01",120000,7);
insert into jugador values (19,"Sasu","Salin",1.90,"Escolta","2017-10-12",100000,7);
insert into jugador values (20,"Jeff","Brooks",2.03,"Ala-Pivot","2011-07-27",145000,7);

update equipo set capitan = 1 where id = 1;
update equipo set capitan = 7 where id = 2;
update equipo set capitan = 3 where id = 3;
update equipo set capitan = 5 where id = 4;
update equipo set capitan = 14 where id = 5;
update equipo set capitan = 12 where id = 6;
update equipo set capitan = 16 where id = 7;

insert into partido values ("2018-10-10",1,2,"102-101");
insert into partido values ("2018-11-17",2,3,"90-91");
insert into partido values ("2018-11-23",3,4,"88-77");
insert into partido values ("2018-11-30",1,6,"66-78");
insert into partido values ("2018-01-12",2,4,"92-90");
insert into partido values ("2019-01-19",4,5,"79-83");
insert into partido values ("2019-02-22",3,6,null);
insert into partido values ("2019-04-27",5,4,null);
insert into partido values ("2019-05-30",6,5,null);



