drop database if exists Vyacheslav;
create database if not exists Vyacheslav;

use Vyacheslav;

delimiter //

drop function if exists diaSemana//
drop function if exists maxTres//
drop function if exists esPalindromo//
drop function if exists sucesion//
drop function if exists esPrimo//
drop function if exists encriptar//

-- EJERCICIO 1

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

-- EJERCICIO 2

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

-- EJERCICIO 3

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

use liga//

drop procedure if exists actualizarPuntos//

-- EJERCICIO 4

create procedure if not exists actualizarPuntos(in equipo smallint(6), in puntosNuevos smallint(6))
deterministic
sql security definer
comment 'Actualiza los puntos de un equipo pasandole los parametros (Equipo, Puntos)'
begin
    if(puntosNuevos < 0) then
        signal sqlstate '45000' set mysql_errno = 5010, message_text = "No puede ser un número negativo";
    elseif  (select equipo in (select id from equipo)) = 0 then
        signal sqlstate '45000' set mysql_errno = 5008, message_text = "No existe el equipo indicado";
    end if;

    update equipo set puntos = puntosNuevos where equipo = id;
end//

create database if not exists prueba//

use prueba//

drop function if exists sumaN//

-- EJERCICIO 5

create function if not exists sumaN (n int unsigned) returns int
deterministic
sql security definer
comment "Suma los primer N numeros pasados"
begin
    declare resultado int default 0;

    while n > 0 do
        set resultado = resultado + n;
        set n = n - 1;
    end while;

    return resultado;
end//

use Vyacheslav//

-- EJERCICIO 6

create function if not exists sucesion(m int) returns decimal(11,10)
deterministic
sql security definer
comment "Devuelve la suma de la sucesion de 1/m empezando por 1/2"
begin
    declare resultado decimal(11,10) default 0;
    declare i int default 2;
    
    while m > 0 do
        set resultado = resultado + (1/i);
        set i = i + 1;
        set m = m - 1;
    end while;
    
    return resultado;
end//

-- EJERCICIO 7

create function if not exists esPrimo(num int unsigned) returns tinyint(1)
deterministic
sql security definer
comment "Devuelve si el numero es primo o no"
begin
    declare i int default 2;
    
    if num = 2 then
        return 1;
    elseif num = 3 then
        return 1;
    elseif num = 5 then
        return 1;
    end if;
    
    while i <= 11 do
        if (mod(num,i) = 0) then
            return 0;
        end if;
        set i = i + 1;
    end while;

    return 1;
end//

-- EJERCICIO 8

use prueba//

drop procedure if exists generarPrimos//

create procedure if not exists generarPrimos(in num int, out cantidad int)
deterministic
sql security definer
comment "Genera primos comprendidos entre 0 y num en una tabla en BD Pruebas"
begin
    declare contador int default 2;
    declare esPrimo tinyint(1) default 1;

    set cantidad = 0;

    create table if not exists primos(numero int);

    truncate primos;

    while num > 1 do
        while contador < num do
            if (num = 2) then
                insert into primos value(num);
            elseif (mod(num,contador) = 0) then
                set esPrimo = 0;
            end if;
            set contador = contador + 1;
        end while;
        if (esPrimo = 1) then
            insert into primos value(num);
            set cantidad = cantidad + 1;
        end if;
        set num = num - 1;
        set esPrimo = 1;
        set contador = 2;
    end while;
end//

-- EJERCICIO 9

use vyacheslav//

create function if not exists encriptar (cadena varchar(255)) returns varchar(255)
deterministic
sql security definer
comment "Encripta la cadena. Poniendo cada caracter el siguiente de la tabla ASCII"
begin
    declare tamanio int default 1;
    declare resultado varchar(255) default "";
    while length(cadena) >= tamanio do
        set resultado = concat(resultado, char(ascii(substring(cadena,tamanio,1))+1));
        set tamanio =  tamanio + 1;
    end while;

    return resultado;
end//

-- EJERCICIO 10

use liga//

drop procedure if exists puntosEncestadosEnMes//

create procedure if not exists puntosEncestadosEnMes()
deterministic
sql security definer
comment "Muestra los puntos de cada equipo obtenidos en los partido de forma mensual"
begin
    declare eqLocal smallint(6);
    declare eqVisitante smallint(6);
    declare mes int;
    declare res1 int;
    declare res2 int;
    declare final tinyint(1) default 0;
    declare CEqLocal cursor for (select elocal from partido where resultado is not null);
    declare CEqVisit cursor for (select evisitante from partido where resultado is not null);
    declare Cmes cursor for (select fecha from partido where resultado is not null);
    declare CResLoc cursor for (select substring(resultado,1,locate("-",resultado) - 1) from partido where resultado is not null);
    declare CResVis cursor for (select substring(resultado,locate("-",resultado) + 1) from partido where resultado is not null);
    declare continue handler for not found set final = true;

    

    create table if not exists puntosMes(equipo smallint(6), fecha date, puntos int);

    truncate puntosMes;

    open CEqLocal;
    open CEqVisit;
    open Cmes;
    open CResLoc;
    open CResVis;

    while not final do
        fetch CEqLocal into eqLocal;
        fetch CEqVisit into eqVisitante;
        fetch Cmes into mes;
        fetch CResLoc into res1;
        fetch CResVis into res2;

        if(eqLocal in (select equipo from puntosMes where month(mes) = month(fecha) and year(mes) = year(fecha))) then
            update puntosMes set puntos = puntos + res1 where equipo = eqLocal and month(mes) = month(fecha) and year(mes) = year(fecha);
        else
            insert into puntosMes values(eqLocal, mes, res1);
        end if;
        if( eqVisitante in (select equipo from puntosMes where month(mes) = month(fecha) and year(mes) = year(fecha))) then
            update puntosMes set puntos = puntos + res2 where equipo = eqVisitante and month(mes) = month(fecha) and year(mes) = year(fecha);
        else 
            insert into puntosMes values(eqVisitante, mes, res2);
        end if;
    end while;

    close CEqLocal;
    close CEqVisit;
    close Cmes;
    close CResLoc;
    close CResVis;

end// 



delimiter ;

