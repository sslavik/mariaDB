use exdvd;

drop procedure if exists llenarAlea;
drop procedure if exists sacarValorMenor;
drop procedure if exists sacarValorMenorConCursor;

delimiter //

create procedure if not exists llenarAlea()
deterministic
sql security definer
comment 'llena una tabla de numeros aleatorios'
BEGIN
declare x, y int;
declare count int default 0;

bucle : WHILE count < 100 DO
    (select truncate(rand() * 100, 0) into x);
    (select truncate(rand() * 100, 0) into y);
    if x > 50 THEN
        insert into ran1 (i) value(x);
    end if;
    if y > 50 THEN
        insert into ran2 (i) value(y);
    end if;
    set count = count + 1;
END WHILE bucle;
END//

create procedure if not exists sacarValorMenor() 
deterministic
sql security definer
comment 'saca el menor valor de las 2 tablas'
BEGIN
    declare limite int default 1;
    declare ofset int default 0;
    declare max int;
    declare x, y int;
    set max = (select count(*) from ran1);
    while ofset < max do
        (select * into x from ran1 limit limite offset ofset);
        (select * into y from ran2 limit limite offset ofset);

        if x < y then
            insert into ran3 (i) value(x);
        else
            insert into ran3 (i) value(y);
        end if;

        set ofset = ofset +1;
    end while;
END//

create procedure if not exists sacarValorMenorConCursor() 
deterministic
sql security definer
comment 'saca el menor valor de las 2 tablas'
BEGIN
    declare terminado tinyint(1) default 0;
    declare x, y int;

    declare cursor1 cursor for select * from ran1;
    declare cursor2 cursor for select * from ran2;
    declare continue handler for not found set terminado = 1;

    open cursor1;
    open cursor2;

    while not terminado do
        fetch cursor1 into x;
        fetch cursor2 into y;

        if x < y then
            insert into ran4 (i) value(x);
        else
            insert into ran4 (i) value(y);
        end if;
    end while;

    close cursor1 ;
    close cursor2 ;
END//


delimiter ;