use formacion;

select * from empleado;

delimiter //

drop trigger if exists bi_empleado//
drop trigger if exists ai_empleado//
drop trigger if exists au_empleado//
drop trigger if exists bu_edicion//

create trigger if not exists bi_empleado before insert on empleado
for each row
begin
    set new.nombre = upper(new.nombre);
end//

create trigger if not exists ai_empleado after insert on empleado
for each row
begin
    if (new.capacitado = 'S') then
        insert into capacitado value (new.codEmp);
    end if;
end//

create trigger if not exists au_empleado after update on empleado
for each row
begin
    if(old.capacitado = 'S' and new.capacitado = 'N') then
        delete from capacitado where codEmp = old.codEmp;
    elseif (old.capacitado = 'N' and new.capacitado = 'S') then
        insert into capacitado value (new.codEmp);
    end if;
end//

create trigger if not exists bu_edicion before update on edicion
for each row
begin
    if (old.profesor <> new.profesor and new.profesor is not null) and exists (select * from matricula 
            where fecha = new.fecha and curso = new.codCurso and empleado = new.profesor) then
        signal sqlstate '45000' set mysql_errno = 5005, message_text = "El profesor asignado ya esta como alumno";
    end if;
end// 

delimiter ;