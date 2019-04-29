use liga;

delimiter //
drop procedure if exists insertarJugador;

create procedure if exists insertarJugador(unNombre varchar(50), unApellido varchar(50), unAltura decimal(3,2), unPuesto varchar(50), fecha_alta datetime, equipo)


delimiter ;