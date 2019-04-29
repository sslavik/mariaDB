drop database if exists Vyacheslav;
create database if not exists Vyacheslav;

use Vyacheslav;

delimiter //

drop function if exists diaSemana//
drop function if exists maxTres//
drop function if exists esPalindromo//

create function if not exists diaSemana (n int) returns char(10) 
deterministic
sql security definer
comment 'Devuelve el día de la semana'
begin
    case n
        when 1 then return "Lunes";
        when 2 then return "Martes";
        when 3 then return "Miércoles";
        when 4 then return "Jueves";
        when 5 then return "Viernes";
        when 6 then return "Sábado";
        when 7 then return "Domingo";
        else
            return "No Existe";
    end case;
end//

create function if not exists maxTres (n1 int, n2 int, n3 int) returns int
deterministic
sql security definer
comment 'Devuelve el mayor de los 3'
begin
    if(n1 > n2 and n1 > n3) then
        return n1;
    elseif (n2 > n1 and n2 > n3) then
        return n2;
    else 
        return n3;
    end if; 
end//

create function if not exists esPalindromo (cadena varchar(255)) returns tinyint(1)
deterministic
sql security definer
comment 'Devuelve 1 si es palindromo y 0 si no es palindromo'
begin
    declare i int default 0;
    declare reverso varchar(255) default '';

    set i = length(cadena);

    while i > 0 do
       set reverso = concat(reverso,substring(cadena, i, 1));
       set i = i - 1; 
    end while;

    if( reverso rlike cadena ) then
        return 1;
    else
        return 0;
    end if;
end//

delimiter ;

select esPalindromo("Hola aloh");
