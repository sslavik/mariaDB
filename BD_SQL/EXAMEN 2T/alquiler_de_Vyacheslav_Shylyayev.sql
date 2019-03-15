-- HECHO POR : VYACHESLAV SHYLYAYEV
-- FECHA : 12 / 03 / 2019

-- EJERCICIO 2
-- NOTA
-- mysql -u alumno -p -h 192.168.102.139 alquiler 
-- 2 A
select nombre from propietario where dni in (select propietario from casa where id in( select idCasa from alquila group by dniA having(count(idCasa) >= 4)));
-- 2 B
select dni, nombre, timestampdiff(year,fechaNac, adddate(now(),14)) edad from inquilino;
-- 2 C
select a.dniA from alquila a join casa c on (c.id = a.idCasa) where precio = (select min(precio) from casa) order by a.dniA;
-- 2 D
select idCasa, truncate(avg(dias),1) as mediaDiasAlquilada from alquila where idCasa in (select idCasa from alquila group by idCasa having(avg(dias) > 2));
-- 2 E
select dni from inquilino i where not exists( 
	select * from alquila a where  not exists (select * from alquila c where c.idCasa = a.idCasa and i.dni = c.dniA)
);
-- 2 F
select dni from inquilino i where not exists( 
	select * from alquila a where not exists ( select * from casa c where c.id = a.idCasa and a.dniA = (select dni from inquilino where nombre = 'ABF') )
);