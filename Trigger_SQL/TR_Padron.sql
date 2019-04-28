/* --- TRIGGERS PARA BASE DE DATOS PADRON ---

_____________________
1 . Que no puedan existir Municipios sin habitantes
2 . Que toda vivienda tenga un propietario como minimo
3 . Toda vivienda no puede tener más de 5 propietarios (BEFORE UPDATE / INSERT)
4 . Todo habitante que tenga una vivienda estará empadronado en el mismo Municipio de la vivienda

_____________________

*/

delimiter //

drop trigger if exists bd_habitante//
drop trigger if exists bd_propietario//
drop trigger if exists bi_propietario//
drop trigger if exists bu_propietario//

create trigger if not exists bd_habitante before delete on habitante
for each row
BEGIN
    if (select count(*) from habitante where empadronado = old.empadronado) = 1 THEN
        signal sqlstate '45000' set mysql_errno = 5000,  message_text = "Un municipio no se puede quedar sin habitantes";
    END IF;
END//

create trigger if not exists bd_propietario before delete on propietario
for each row 
BEGIN
    if(select count(*) from propietario where vivienda = old.vivienda) = 1 THEN
        signal sqlstate '45001' set mysql_errno = 5001, message_text = "No puede haber viviendas sin propietarios";
    end if;
END//

create trigger if not exists bi_propietario before insert on propietario
for each row 
BEGIN
    if(select count(*) from propietario where vivienda = new.vivienda) = 5 THEN
        signal sqlstate '45002' set mysql_errno = 5002, message_text = "No puede haber viviendas con MAS de 5 propietarios";
    end if;
    if(select empadronado from habitante where new.habitante = id) not rlike (select municipio from vivienda where nrc = new.vivienda) THEN
        signal sqlstate '45003' set mysql_errno = 5003, message_text = "Para ser propietario de esta vivienda primero requiere empadronarse en ese municipio";
    end if; 
END//

create trigger if not exists bu_propietario before insert on propietario
for each row 
BEGIN
    if(select count(*) from propietario where vivienda = new.vivienda) = 5 THEN
        signal sqlstate '45002' set mysql_errno = 5002, message_text = "No puede haber viviendas con MAS de 5 propietarios";
    end if;
    if(select empadronado from habitante where new.habitante = id) not rlike (select municipio from vivienda where nrc = new.vivienda) THEN
        signal sqlstate '45003' set mysql_errno = 5003, message_text = "Para ser propietario de esta vivienda primero requiere empadronarse en ese municipio";
    end if; 
END//



delimiter ;