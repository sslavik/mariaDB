-- SACAMOS TODOS LOS JUGADORES QUE ESTEN EN (IN) ALTURA MAXIMa
select nombre, apellido, altura from jugador 
    where altura = (select max(altura) from jugador);
-- USO DE FUNCIONES PARA SACAR MAXIMO [MAX(col)] MINIMO [MIN(col)] SUMA [SUM(x,y)] MEDIA [AVG(col)] CUENTA [COUNT(col)] 
select max(altura) as elMasAlto, min(altura) as elBajito, sum(altura) as SumanTotal, avg(altura) as Media, count(altura) as CuantasAlturas from jugador;

-- AGRUPAR MAXIMOS Y LOS MINIMOS DE LAS ALUTRAS POR EL EQUIPO
-- REALIZANDOLO CON UN JOIN (QUE ES EL PRODUCTO CARTESIANO DE LOS DOS FILTRADO CON UN WHERE)
select e.nombre ,max(j.altura), min(j.altura), count(j.equipo) from jugador j, equipo e where e.id = j.equipo group by equipo;
-- LO MISMO PERO CON UN JOIN------ SIENDO ESTA LA MÁS CORRECTA PARA ELISEO
select e.nombre, max(j.altura), min(j.altura), count(j.equipo) from jugador j join equipo e on (j.equipo = e.id) group by j.equipo;

select if(locate(' ',apellido) = 0, concat(upper(left(apellido,1)),substring(apellido,2)), concat(upper(left(apellido,1)),substring(apellido,2,locate(' ',apellido)-1))) from jugador;

-- SUELDO MEDIO DE CADA EQUIPO

select e.nombre, round(avg(j.salario),1) as salario_medio from jugador j join equipo e on j.equipo = e.id group by e.id;