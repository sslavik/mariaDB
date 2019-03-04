/*
Vamos a exportar a CSV la base de datos POSTALES

si estamos trabajando con un servidor todos los volcados se van a hacer de manera local al Servidor
y no se vuelca en el dispositivo del cliente. 

Por eso lo que haremos es volcarlo al "/tmp" que es una ruta que es pública a todos los clientes del
mismo servidor. Así podemos obtener el archivo

LA SINTAXIS DEL VOLCADO : 
SELECT customer_id, firstname, surname INTO OUTFILE '/tmp/customers.txt'
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  FROM customers;


        Si queremos ver la informacion de un archivo es con file -i "file_path"
*/

-- select * from provincias into outfile '/tmp/provincias.csv' 
 --   fields terminated by ';' 
 --   lines terminated by '\n';
-- select * from localidades into outfile '/tmp/localidades.csv'
  --  fields terminated by ';'
  --  lines terminated by '\n';
-- select * from calles into outfile '/tmp/calles.csv'
 --   fields terminated by ';'
 --   lines terminated by '\n';


/*
En caso de lo que queramos es introducir todos los datos que estan en el CSV a nuestra base de datos
ES:
SINTAXIS DE INTRODUCCION:
LOAD DATA
    [LOW_PRIORITY | CONCURRENT] [LOCAL]
    INFILE 'file_name'
    [REPLACE | IGNORE]
    INTO TABLE tbl_name
    [PARTITION (partition_name [, partition_name] ...)]
    [CHARACTER SET charset_name]
    [{FIELDS | COLUMNS}
        [TERMINATED BY 'string']
        [[OPTIONALLY] ENCLOSED BY 'char']
        [ESCAPED BY 'char']
    ]
    [LINES
        [STARTING BY 'string']
        [TERMINATED BY 'string']
    ]
    [IGNORE number {LINES | ROWS}]
    [(col_name_or_user_var
        [, col_name_or_user_var] ...)]
    [SET col_name={expr | DEFAULT},
        [, col_name={expr | DEFAULT}] ...]
*/