use liga;

/*
    Vamos a obtener la cantidad de partidos ganados de forma seguida. Para ello accederemos a 
    la puntuación de cada partido y comparando el resultado sacaremos un equipo y lo comprobaremos.
*/

drop procedure if exists contarGanadas;

delimiter //

create procedure if not exists contarGanadas( in equipo int , out cantidad int ) 
deterministic
sql security definer
comment 'Obtener partidos ganados de forma seguida'
begin
    -- VARIABLES
    declare final tinyint(1) default 0;
    declare value1 int default 0;
    declare value2 int default 0;
    declare equipoL int;
    declare equipoV int;
    declare contador int default 0;
    declare maxCont int default 0;
 
    -- CURSORS
    declare res1 cursor for (select substring(resultado, 1, locate('-', resultado) - 1) from partido where (elocal = equipo or evisitante = equipo) and resultado is not null );
    declare res2 cursor for (select substring(resultado, locate('-', resultado) + 1) from partido where (elocal = equipo or evisitante = equipo) and resultado is not null );
    declare locl cursor for ( select elocal from partido );
    declare visit cursor for ( select evisitante from partido );
    declare exit handler for not found set final = true;
    

    open res1;
    open res2;
    open locl;
    open visit;

    while not final do 
        fetch res1 into value1;
        fetch res2 into value2;
        fetch locl into equipoL;
        fetch visit into equipoV;

        set value1 = cast(value1 as int);
        set value2 = cast(value2 as int);
        select value1, value2;
        if( value1 > value2 and equipoL = equipo ) then
            set contador = contador + 1;
        elseif (value1 < value2 and equipoV = equipo ) then
            set contador = contador + 1;
        else
            if (maxCont < contador) then
                set maxCont = contador;
                set contador = maxCont;
            end if;
            set contador = 0;
        end if;
    end while;

    close res1;
    close res2;
    close locl;
    close visit;
end//

delimiter ;