use animales;

delimiter //

drop trigger if exists bi_animal//
drop trigger if exists ai_animal//
drop trigger if exists bu_animal//
drop trigger if exists ad_animal//

create trigger if not exists bi_animal before insert on animal
for each ROW
BEGIN
    if (LENGTH(new.nombre)>10) THEN
        signal sqlstate '45000' set MYSQL_ERRNO = 5000, MESSAGE_TEXT = "Nombre demasiado largo para un animal";

    elseif (new.nombre is null) THEN
        signal sqlstate '45000' set MYSQL_ERRNO = 5001, MESSAGE_TEXT = "Nombre no asignado";

    elseif  ((select numero from animal_count) >= 10) THEN
        signal sqlstate '45000' set MYSQL_ERRNO = 5002, MESSAGE_TEXT = "Limite de animales superado";
    end if;
END//

create trigger if not exists bu_animal before update on animal
for each row
BEGIN
    if (LENGTH(new.nombre)>10) THEN
        signal sqlstate '45000' set MYSQL_ERRNO = 5000, MESSAGE_TEXT = "Nombre demasiado largo para un animal";

    elseif (new.nombre is null) THEN
        signal sqlstate '45000' set MYSQL_ERRNO = 5001, MESSAGE_TEXT = "Nombre no asignado";
    end if;

END//

create trigger if not exists ai_animal after insert on animal
for each row 
BEGIN
    update animal_count set numero = numero + 1;
END//

create trigger if not exists ad_animal after delete on animal 
for each row 
BEGIN
    update animal_count set numero = numero - 1;
END//

delimiter ;