delimiter //

drop procedure if exists nPrimos//

create procedure if not exists nPrimos (in n int, in m int)
deterministic
sql security invoker
comment 'Devuelve los numeros primos entre N y M'
begin 
    declare i int default n;

    if(n<0)then
        set i = 0;
    end if;

    while (i <= m) do
        if(esPrimo(i)) then
            select i;
        end if;
        set i = i + 1;
    end while;
end//

drop function if exists esPrimo//

create function if not exists esPrimo(num int) returns tinyint(1)
deterministic
sql security invoker
comment 'Dice si un numero es primo o no'
begin
    declare i int default 2;
    case num
        when 0 then return 0;
        when 1 then return 0;
        else
            while i<num do
                if(mod(num,i)=0) then
                    return 0;
                end if;
                set i = i + 1;
            end while;
    end case;
    return 1;
end//

delimiter ;