use cine;

delimiter //

drop procedure if exists contarButacas// -- ESTO BORRA EL PROCEDIMIENTO PARA PODER SOBREESCRIBIRLO
drop procedure if exists contarButacasLibres//

create procedure contarButacas( out nSalas int )
deterministic
SQL SECURITY invoker
comment ' Devuelve las butacas que hay en una sala '
BEGIN
    select count(*) into nSalas from sala;
    -- OTRA OPCION ES :
    -- set nSalas = (select count(*) from sala); -- IMPORTANTE PONER LOS PARENTESIS
END//

create procedure contarButacasLibres( out nSalas int, in libres tinyint(1))
deterministic
SQL SECURITY invoker
comment ' Devuelve las butacas libres o ocupadas que hay en una sala '
BEGIN
    if libres = 1 then
        select count(*) into nSalas from sala where estado = 'l';
    else 
        select count(*) into nSalas from sala where estado rlike '[^l]';
    end if;
END//

use liga//

drop function if exists contarJugadores//

create function contarJugadores(idEquipo int) returns INT
deterministic
sql security invoker
comment 'los jugadores existentes del equipo pasado'
BEGIN
    return (select count(*) from jugador where equipo = idEquipo);
END//

delimiter ;