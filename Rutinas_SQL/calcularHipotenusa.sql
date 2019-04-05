-- NECESITA UNA BASE DE DATOS por ejemplo
-- use liga;

delimiter //

drop function if exists calcHipotenusa;

create function calcHipotenusa(cateto1 decimal(10,2), cateto2 decimal(10,2)) returns decimal(10,2)
deterministic
sql security definer
comment 'Devuelve la hipotenusa de un triangulo rectangulo pasando los catetos'
BEGIN
    return sqrt((cateto1 * cateto1) + (cateto2 * cateto2));
END//


