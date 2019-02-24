/* VYACHESLAV SHYLYAYEV
Ejercicio 2. Dada una base de datos de ordenadores e impresoras con las siguientes tablas: 
Producto (#fabricante, #modelo, tipo)    
PC (#modelo, velocidad, ram, hd, cd, precio)    // Se lleva el atto FABRICANTE de la tabla producto
Impresora (#modelo, color, tipo, precio)        // Se lleva el atto FABRICANTE de la tabla producto
Realizar en SQL las siguientes consultas:
*/

-- 1. Encontrar el modelo, velocidad y tamano de disco duro (hd) de todos los PCs  cuyo precio sea inferior a 1600€. 
select modelo, velocidad, hd from pc where precio < 1600;
-- 2. Repetir la consulta de (a), pero cambiando el nombre a las columnas velocidad como Megaherzios y hd como Gigabytes. 
select modelo, velocidad as Megaherzios, hd as Gigabytes from pc where precio < 1600;
-- 3. Encontrar todas las filas de la tablas de Impresoras que son en color. El valor de la columna color es booleano con los valores “V” y “F”. 
select * from impresora where color = 'V';
-- 4. Encontrar la velocidad media de los PCs. 
select avg(velocidad) from pc;
-- 5. Decir los fabricantes y la velocidad de los PC?s con disco duro de tamano mayor o igual a 1 Gigabyte. 
select fabricante, velocidad from pc where hd >= 1024;
-- SUPONIENDO QUE LOS FABRICANTES SOLO ESTAN EN PRODUCTOS 
    select p.fabricante, p2.velocidad from producto p join pc p2 on (p.modelo = p2.modelo) where p2.hd >= 1024; -- USING (MODELO) 
-- 6. Encontrar los fabricantes de los PC?s con velocidad superior a 160 Mhz.
select fabricante from pc where velocidad > 160;
-- SUPONIENDO QUE LOS FABRICANTES SOLO ESTAN EN PRODUCTOS 
    select p.fabricante from producto p join pc f on (p.modelo = f.modelo) where f.velocidad > 160;
