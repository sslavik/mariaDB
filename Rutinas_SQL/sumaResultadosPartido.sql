delimiter //

drop function if exists sumaResultados;

create function sumaResultados(fechaPass date, localPass smallint(6), visitantePass smallint(6)) returns integer
deterministic
sql security definer
comment 'Devuelve la suma de los resultados XXX-XXX, Dados en un partido de baloncesto'
BEGIN
    declare result char(7);
    declare resultadoA integer;
    declare resultadoB integer;
    
    set result = (select resultado from liga.partido
        where fecha = fechaPass and elocal = localPass and evisitante = visitantePass);

    set resultadoA = cast((select substring(result, 1, locate('-',result) - 1)) as integer);
    set resultadoB = cast((select substring(result, locate('-', result) + 1)) as integer);
    
    return resultadoA + resultadoB;
END//

delimiter ;