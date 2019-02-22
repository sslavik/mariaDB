-- 2. Nombre de empleados inscritos exactamente en 3 cursos.
select empleado, nombre from empleado e where 3 = (select count(*) from inscrito i where i.empleado = e.empleado);
-- PRIMERO hacemos un grupo de Cursos en la tabla INSCRITOS. Pero cuando necesitamos comparar un empleado 
-- con el conteo de inscritos en cursos. lo tendremos que mirar por inscrito.empleado = empleado.empeleado

-- 3. Nombre de cursos que no han sido escogidos por ningún empleado
-- CON NOT EXISTS (CORRELACIONADA)
-- select * from curso c where not exists(select curso from inscrito i where i.curso = c.curso);
-- CON NOT IN
-- select * from curso where curso not in (select curso from inscrito);
-- CON LEFT JOIN (CORRELACIONADA)
select * from curso c left join inscrito i on i.curso = c.curso where i.curso is null;

-- 4. Códigos de empleados que no se hayan inscrito en ningún curso
-- CON LEFT JOIN
-- select e.* from empleado e left join inscrito i on i.empleado = e.empleado where i.empleado is null;
-- COM NOT EXISTS
select e.* from empleado e where not exists (select i.empleado from inscrito i where i.empleado = e.empleado);

-- 5.Nombres de empleados que se hayan inscrito en todos los cursos.
-- CORRELACIONADA
/*select nombre from empleado e 
    where (select count(*) from curso) = (select count(distinct(curso)) from inscrito i 
    where e.empleado = i.empleado);*/
-- DOBLE NEGACION
select * from empleado e where not exists 
(select * from curso c where not exists 
(select * from inscrito i where i.curso = c.curso and i.empleado = e.empleado));

-- 6. Códigos de empleados que se han inscrito en al menos todos los cursos que haya elegido el empleado con código “SMG”
-- DOBLE NEGACION
select * from empleado e where not exists(
    select * from inscrito i1 where i1.empleado = 'SMG' and not exists (
        select * from inscrito i2 where i2.curso = i1.curso and i2.empleado = e.empleado and e.empleado != 'SMG'
    )
);

-- 7. 
select count(*) from empleado e where e.sueldo = (select max(sueldo) from empleado) group by e.empleado;