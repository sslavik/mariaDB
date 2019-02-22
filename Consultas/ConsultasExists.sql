-- Sacar todos los datos del capitan de un equipo
select * from jugador j where exists (select * from equipo e where e.capitan = j.id);
-- Lo que hacemos es preguntar a la tabla EQUIPO si alguno de sus capitanes es igual al ID del JUGADOR EXTERNO
select j.id, j.nombre, j.apellido from jugador j join equipo e on j.id = e.capitan;
-- Saber la media del equipo de cada jugador y la diferencia entre su salario y la media
select j.id, j.nombre, j.apellido, j.salario, 
(select round(avg(salario),2) from jugador j2 where j.equipo = j2.equipo) as SalarioMedio, 
(select salario - SalarioMedio) as DiferenciaSalarial 
from jugador j;

-- Salario maximo de la suma de cada equipo
select max(suma) from (select equipo, sum(salario) as suma from jugador group by equipo) as TablaNueva;

