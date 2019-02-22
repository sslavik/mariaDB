-- Cuando usemos el producto cartesiano siempre lo filtremos con un Join / On en vez de un Where. 
select * from jugador j , equipo e , partido p where e.id = j.equipo and e.id = p.elocal;
-- Mostrar el nombre del equipo en vez del id en el partido. CON INNER JOIN
select p.fecha, e.nombre as ELocal, e2.nombre as EVisitiante, p.resultado 
    from partido p 
    inner join equipo e on e.id = p.elocal 
    inner join equipo e2 on e2.id = p.evisitante; 
-- Otra forma de hacerlo
select p.fecha, e.nombre as Elocal, e2.nombre as Evisitante, p.resultado
    from partido p
    inner join (equipo e, equipo e2) on e.id = p.elocal and e2.id = p.evisitante;
-- Mostrar todos los equipos que haya. Y de aquellos que haya jugado partido el resultado y si no pues null
select p.fecha, e.id , e.nombre, p.resultado from equipo e left join partido p on p.elocal = e.id;
-- Usamos el LEFT JOIN debido a que queremos mostrar prioritariamente los resultados de la tabla de la izquierda
-- Y filtramos por aquellos que se comparatan en la tabla de la derecha. (Concuerde en el ON)
-- Mostrar todos los equipos que hay en la liga y de aquellos que hayan jugado partido mostrar fecha y resultado
select e.nombre as Elocal, e2.nombre as Evisitante, p.fecha, p.resultado from equipo e left join (partido p, equipo e2) on e.id = p.elocal and e2.id = p.evisitante ;