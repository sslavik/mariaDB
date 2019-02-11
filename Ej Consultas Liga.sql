-- 1. Obtener datos de todos los jugadores menos de los equipos 1, 2 y 3.
select * from jugador where equipo not in (1,2,3);
-- 2. Obtener el número de ciudades en las que hay equipos.
select count(id) as Cuantos, ciudad from equipo group by ciudad;
-- 3. Listado de partidos ordenado por equipo, local y fecha.
select * from partido order by elocal, fecha;
-- 4. Número de partidos ganados por equipos locales.
select count(elocal) from partido where substring(resultado,1,locate('-',resultado)-1 ) > substring(resultado,locate('-',resultado) + 1);
-- 5. Nombre de jugadores que empiecen por “A” y tengan al menos dos vocales.
select * from jugador where nombre rlike '^a.*[aeiou]';
-- 6. Datos del último partido, incluyendo el nombre de los equipos y jugadores.

-- 7. Datos del equipo y del capitán para equipos que hayan ganado más de dos
-- partidos como visitantes.
-- 8. Mostrar los equipos que no han jugado ningún partido como locales.

-- Equipos que tengan 3 o más jugadores en la TABLA
select id, nombre from equipo e where 2 < (select count(equipo) from jugador j where j.equipo = e.id);
-- Los nombres de los equipos que tengan al menos 2 jugadores en el mismo puesto
select distinct(e.nombre), j1.puesto from equipo e, jugador j1 where e.id = j1.equipo and 2 <= (select count(*) from jugador j where j.equipo = e.id and j.puesto = j1.puesto);
 