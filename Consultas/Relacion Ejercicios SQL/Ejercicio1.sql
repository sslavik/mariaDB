-- EJERCICIO 1 
    -- VYACHESLAV SHYLYAYEV

-- CREACION DE LA BASE DE DATOS

/*
-- Borramos y creamos la base de datos "cinema". Porque me lo puedo permitir para las pruebas
drop database if exists cinema;
create database if not exists cinema;
use cinema;

-- DROPS

drop table if exists protagoniza;
drop table if exists estrella;
drop table if exists pelicula;
drop table if exists estudio;

-- CREATES

create table if not exists estudio (
    nombre varchar(100),
    direccion char(50) not null,

    primary key (nombre)
); 
create table if not exists pelicula (
    titulo varchar(100),
    anio date not null,
    duracion integer not null,
    nombre_estudio char(100),

    primary key (titulo, anio),
    foreign key (nombre_estudio) references estudio (nombre) on delete restrict on update cascade
);     
create table if not exists estrella (
    nombre varchar(100) primary key,
    direccion char(100) not null,
    sexo enum ('v','m') not null,
    fNac date not null
);
create table if not exists protagoniza (
    titulo_pelicula varchar(100),
    anio_pelicula date,
    nombre_estrella varchar(100),

    primary key (titulo_pelicula, anio_pelicula, nombre_estrella),
    foreign key (titulo_pelicula, anio_pelicula) references pelicula (titulo, anio) on delete restrict on update cascade,
    foreign key (nombre_estrella) references estrella (nombre) on delete restrict on update cascade
); 

insert into estudio values ('MGM', 'C/ Alcalá');
insert into estudio values ('Universal Pictures', 'Hollywood');
insert into estudio values ('Walt Disney', 'Hollywood');

insert into estrella values ('Penelope', 'C/ Malibú', 'm', '1970-03-22');
insert into estrella values ('Jose Carlos', 'C/ Malibú', 'v', '1965-02-12');
insert into estrella values ('Rosa', 'C/ Piruleta Dorada', 'm', '1973-08-11');
insert into estrella values ('Vicent', 'C/ Malibu', 'v', '1989-05-21');

insert into pelicula values ('Le Amoré','1980-07-04',122,'MGM');
insert into pelicula values ('Le Amoré','1995-07-04',112,'MGM');
insert into pelicula values ('Fast & Furious','2000-04-24',94,'Universal Pictures');
insert into pelicula values ('El nombre de la rosa','1992-07-04',110,'MGM');
insert into pelicula values ('Lo que el viento se llevo','1990-07-04',90,'Walt Disney');
insert into pelicula values ('La dama y el vagabundo','1990-07-04',122,'Walt Disney');

insert into protagoniza values ('Le Amoré','1980-07-04','Jose Carlos');
insert into protagoniza values ('Le Amoré','1995-07-04','Rosa');
insert into protagoniza values ('Fast & Furious','2000-04-24','Vicent');
insert into protagoniza values ('El nombre de la rosa','1992-07-04','Vicent');
insert into protagoniza values ('Lo que el viento se llevo','1990-07-04','Penelope');
insert into protagoniza values ('La dama y el vagabundo','1990-07-04','Penelope');

*/
use cinema; 

-- CONSULTAS EJERCICIO 1
-- 1. Encontrar la dirección de los estudios “MGM”.    
select direccion from estudio where nombre = "MGM";   
-- 2. Encontrar todas las estrellas que participaron en películas realizadas en 1980 o en  alguna película que contenga la palabra “Amor” en el título.       
select * from estrella e join protagoniza p on (p.nombre_estrella = e.nombre)
    where year(p.anio_pelicula) = 1980 or p.titulo_pelicula like '%Amor%'; -- rlike 'Amor'. Tambien vale
-- 3. ¿Quién fue la estrella masculina de “El nombre de la rosa”?  
select * from estrella e where e.sexo = 'v' and exists (
    select * from protagoniza p where p.nombre_estrella = e.nombre and p.titulo_pelicula = "El nombre de la rosa"
);
-- 4. ¿Qué películas tienen mayor duración que “Lo que el viento se llevo?”       
select * from pelicula where duracion > all (
    select duracion from pelicula where titulo = "Lo que el viento se llevo"
);
-- 5. Encontrar el título y la duración de todas las películas producidas por los estudios Disney en el año 1990, ordenando la salida por su duración.     
select titulo, duracion from pelicula 
    where nombre_estudio like '%Disney%' and year(anio) = 1990 order by duracion;
-- 6. Encontrar todas las estrellas que son hombres o viven en Malibú (tienen Malibú como parte de su dirección).     
select * from estrella where sexo = 'v' or direccion rlike 'Malibú';
-- 7. ¿Qué estrellas distintas aparecen en las películas producidas por la MGM en 1995?   
select distinct(nombre), e.* from estrella e join protagoniza p on (e.nombre = p.nombre_estrella) where year(p.anio_pelicula) = 1995 and p.titulo_pelicula in (
    select pe.titulo from pelicula pe where pe.nombre_estudio = 'MGM'
);
--    (Si una aparece varias veces mostrarla sólo una vez).
-- 8. Encontrar la suma de la duración de todas las películas de cada estudio.
select sum(duracion) from pelicula group by nombre_estudio;