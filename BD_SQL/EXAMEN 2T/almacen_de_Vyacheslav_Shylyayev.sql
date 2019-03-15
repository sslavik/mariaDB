-- HECHO POR : VYACHESLAV SHYLYAYEV
-- FECHA : 12 / 03 / 2019

-- EJERCICIO 1 
-- 1 A
select codigoPieza, round(precio * 0.21 + precio, 2) as precioIVA from suministra;
-- 1 B
select codigoPieza, round(avg(precio),2) as mediaPrecio from suministra group by codigoPieza;
-- 1 C
select nombre from proveedores where id in (select idProveedor from suministra where codigoPieza = '1');
-- 1 D
select p.nombre from proveedores p inner join suministra s on (p.id = s.idProveedor) where s.codigoPieza = '1';
-- 1 E
select nombre from piezas where codigo = any (select codigoPieza from suministra where idProveedor = 'p1');
-- 1 F
select pi.nombre, p.nombre, s.precio from suministra s join piezas pi on (pi.codigo = s.codigoPieza) join proveedores p on (p.id= s.idProveedor); 
-- 1 G
select * from piezas where nombre rlike '^[aeiouAEIOU].*[0-9]$';
-- 1 H
select * from piezas where nombre rlike '^[a-zA-Z].*[0-9].*[0-9]';
-- 1 I
select pi.nombre, p.nombre, s.precio from suministra s join piezas pi on (s.codigoPieza = pi.codigo) join proveedores p on (p.id = s.idProveedor)
	where s.precio = (select max(precio) from suministra);
-- 1 J
select codigo, nombre from piezas where codigo in (
	select codigoPieza from suministra group by codigoPieza having(count(codigoPieza) >= 3)
);
-- 1 K
select p.codigo, p.nombre, ifnull(s.idProveedor,'[nadie]') as id_Proveedor, ifnull(s.precio,'0.00') as precio from piezas p left join suministra s on (s.codigoPieza = p.codigo);
-- 1 L
mysqldump -u root -p almacen proveedores piezas > almacenParcial.dump

