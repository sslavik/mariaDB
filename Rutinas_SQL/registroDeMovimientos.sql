use exdvd;

delimiter //

drop function if exists movimiento(id, fecha, cantidad);

create function if not exists movimiento(id int, fecha date, cantidad) returns int 
deterministic
SQL SECURITY definer
comment 'Controla la gestion de movimientos en una cuenta'
BEGIN
--  0 -> ok
-- -1 -> descubierto
-- -2 fecha en el futuro
-- -3 id cuenta No existe
END//

delimiter ;