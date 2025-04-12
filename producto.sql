CREATE DATABASE VENT2025; /*creo*/
use VENT2025; /*intruccion*/
create table categoria
(
id integer not null primary key, /*TABLA CATEGORIA*/
descripcion varchar(20) not null
);
insert into categoria values (1,'COMIDA'); 
insert into categoria values (2,'BEBIDAS');

CREATE TABLE PRODUCTO 
(
CODIGO varchar(4) NOT NULL  PRIMARY KEY,
NOMBRE VARCHAR (40) NOT NULL,
PRECIO FLOAT NOT NULL,
IDCAT INTEGER NOT NULL,
foreign Key (IDCAT) references categoria (id)
 on update cascade
    on delete cascade
    );
insert into producto values ('P001', 'HAMBURGUESA SIMPLE','15',1);/* productos de categoria*/
insert into producto values ('P002', 'HAMBURGUESA DOBLE','20',1);/* productos de categoria*/
insert into producto values ('P003','COCA COLA PERSONAL','10',2);/* productos de categoria*/
insert into producto values ('P004', 'COCACOLA PEQUE','5',2);/* productos de categoria*/
insert into producto values ('P005', 'LOMITO','18',1);/* productos de categoria*/

SELECT * fROM CATEGORIA;
SELECT * FROM PRODUCTO;

select *
from producto 
where precio < 20 and nombre LIKE 'H%';

/* MOSTRAR LOS PRODUCTOS CON PRECIO MENOR A 20 Y SU NOMBRE =H*/
select *
from producto 
where precio >=5 and precio <=15;

/* MOSTRAR LOS PRODUCTOS QUE SU PRECIO ESTE ENTRE 5 Y 15BS*/
 select*
 from producto 
 where precio between 5 and 15; /* entre 5 y 15 between*/
 
 /*mostrar productos de la categoria comida*/
 select CODIGO ,NOMBRE ,PRECIO/*estructura, LO QUE MUESTRO*/
 from producto,categoria
 where IDCAT=ID AND DESCRIPCION='COMIDA';
 
 /*mostrar el id de la categoria comida */
 SELECT ID 
 FROM CATEGORIA 
 WHERE DESCRIPCION ='COMIDA';
 
/* consultas anidadas*/
/*mostrar el codigo ,nombre,precio,ic de categoria */
/*ver si categoria esta dentro de producto y mostrar*/
 SELECT *
 FROM PRODUCTO
 WHERE IDCAT IN ( SELECT ID 
     FROM CATEGORIA 
                    WHERE DESCRIPCION = 'COMIDA'
                    );

/*crear TABLA facturA*/
CREATE TABLE FACTURA 
(
NROF INTEGER NOT NULL primary KEY ,
NROAUTORIZACION INTEGER NOT NULL,
FECHA DATE NOT NULL ,
NIT INTEGER NOT NULL,
NOMBRE VARCHAR (50) NOT NULL ,/*50 CARACTERES*/
MONTOTOTAL FLOAT NOT NULL
);

/*INSERTAR DATOS */
SELECT *
FROM FACTURA;
INSERT INTO FACTURA VALUES(100,18181,'2025/01/10',111,'JOAQUIN CHUMACERO', 25); /*A;O MES DIA */
INSERT INTO FACTURA VALUES(101,18181,'2025/01/10',222,'SATURNINO MAMANI', 50); 
INSERT INTO FACTURA VALUES(102,18181,'2025/01/15',111,'JOAQUIN CHUMACERO', 30); 

/*uso cuando tengo un nit que es llave primaria duplicada*/
UPDATE FACTURA SET NIT=111 WHERE NROF=102;

/*TABLA VENDE */
CREATE TABLE VENDE 
(
 NROF INTEGER NOT NULL, /*MISMO TIPO DE DATO DE Factura */
 CODIGO VARCHAR (4) NOT NULL, /*MISMO TIPO DE DATO DE PRODUCTO */
 CANTIDAD INTEGER NOT NULL,
 PRECIO FLOAT NOT NULL,
 PRIMARY KEY (NROF,CODIGO),/* UNA SOLA LLAVE COMPUESTA DE DO ATRIBUTOS*/
 foreign Key (NROF) references FACTURA(NROF) /*PROTEJO LA INTEGRIDAD REFERENCIAL, NROF HACE REFERENCIA A PRODUCTO DE NROF COMO LLAVE FORANEA Y SI CAMBIO EN FACTURA DEBO CAMBIAR EN VENDE*/
 on update cascade /*AUMENTO */
    on delete cascade,/*ELIMINO*/
foreign Key (CODIGO) references PRODUCTO(CODIGO)
 on update cascade
    on delete cascade 
);

/*INSERTAR DATO DE VENDE */
INSERT INTO VENDE VALUES (100,'P001',1,15);
INSERT INTO VENDE VALUES (100,'P003',1,10);
INSERT INTO VENDE VALUES (101,'P002',2,20);
INSERT INTO VENDE VALUES (101,'P003',1,10);
INSERT INTO VENDE VALUES (102,'P002',2,15);

DROP TABLE vende;


INSERT INTO VENDE VALUES (100,'P006',1,15);/*NO PERMITIDO POR LLAVE FORANEA , NO EXISTE */
UPDATE VENDE SET PRECIO =10 WHERE NROF=100 AND CODIGO='P003';/*TENGO DOS LLAVES */ /*USO ESTO CUANDO INSERT INTO VENDE VALUES (100,'P003',1,15); PA CAMBIAR EL 15 EN 10*/

SELECT *
FROM VENDE;

/*MOSTRAR LOS PRODUCTOS COMPRADOS POR SATURNINO MAMANI*/
/*1RO BUSCO LA FACTURA DE SATURNINO MAMANI NROF=101, SUS PRODUCTOS P002, P003 DE VENDE Y PRODUCTO , OSEA PRECIO Y PRODUCTO , ENTONCES SON 3 TABLAS */

/*1RO IDENT DE QUE TABLA SALEN LOS DATOS */
/*3ROCRITERIO DE BUSQUEDA , LA CONDICION ES SATURNINO*//* 4TO LOS DATOS A MOSTRAR CODIGO,NOMBRE , PRECIO*/
SELECT PRODUCTO.CODIGO,PRODUCTO.NOMBRE /*4TO*/
FROM FACTURA,VENDE,PRODUCTO /*1RO*/
WHERE FACTURA.NROF=VENDE.NROF AND VENDE.CODIGO=PRODUCTO.CODIGO AND 
FACTURA.NOMBRE='SATURNINO MAMANI';/*2DO UNIR FACTURA Y VENDE UNIR CODIGP Y PRODUCTO ,IDENTIFICO CUAL ESTOY RELACIONANDO*/

/*consultas anidadas*/
select codigo , nombre
from producto
where codigo in 
 (select codigo  /*solo muestra codigo*/
 from vende 
  where nrof in(select nrof 
     from factura
     where nombre='saturnino mamani'
   ) /*muestra codigo del producto*/
  /*result 101*/
 );
    /*mostrar las facturas donde se haya vendido el producto coca cola personal */
   /* select nrof , nombre 
     (select nrof 
           from vende 
           where codigo in (select codigo 
       from producto
       where nombre='coca cola personal'
       )
   )*/
select FACTURA.NROF, FACTURA.FECHA,FACTURA.MONTOTOTAL /*datosn a mostrar,4to*/ /* de que tabla sacar los datos , indetificar las tablas*/ 
from FACTURA , VENDE , PRODUCTO/*como se relacionan2do*/
where factura.nrof=vende.nrof and vende.codigo=producto.codigo /*relacion de factura a vende y de vende a producto2do*/
 and producto.nombre='coca cola personal';/*criterio de busqueda3ro*/
    
    
/*mostrar el nit y nombre de las personas que han commperado productos de la categoria bebida */
select nit,factura.nombre /*datos a mostrar, especifico que tipo de nombre quiero mostrar*/
from factura , vende , producto , categoria
where factura.nrof=vende.nrof and vende.codigo=producto.codigo and  idcat=id
  and descripcion = 'bebidas';/*producto.idcat=categoria.id and categoria.nombre='bebidas';*/
  
  /*borrar base */
  drop database VENT2025;

/*mostrar la cantidad de facturas*/
select*
from factura; /*muestra las facturas pero yo quiero el numero*/
 select count(*)
 from factura; /*3*/
 
 /*mostrar el monto total ingresado */
 select sum(montototal) /*sum hace sumar toda la columna */
 from factura ; /*105*/
 
 /*cual es el monto mas alto vendido*/ 
 select max(montototal) /*max elije el monto total , seleecione el monto maximo de la columna */
 from factura;
 
 /*cual es el monto mas bajo */
 select min(montototal)
 from factura;
 
 /*cual es el monto promedio*/
 select avg(montototal) /*saca el promedio*/
 from factura;
 
 
 
 
/* select*
 from categoria ; /*cargar tablas */
 
/* select *
 from producto;*/
 
 /*mostrar el precio promedio de los productos de la categoria comida */
 /*select * muestro toda la tabla */
 select avg(precio)  /*4to paso datos a mostrarn result 17,66666666666668*/
 from producto,categoria /*1er paso*/
 where idcat=id and descripcion = 'çomida' ;/*2do paso y 3ro criterio de busqueda*/
 
 
 /*mostrar las cantidad de productos de la categoria comida*/
 /*mostrara la cantidad de los productos de la categoria comida */
 select count(*)  /*4to paso datos a mostrar*/
 from producto,categoria /*1er paso*/
 where idcat=id and descripcion = 'çomida' ;/*2do paso y 3ro criterio de busqueda*/
 /*select count , es para contar */
 
 
 /*mostrar cuantas veces se ha vendido el producto hamburguesa doble */
 select count(*) /*(vende.codigo) en vez de count */
 from  vende , producto/*que tablas participan*/
 where vende.codigo=producto.codigo and nombre = 'hamburguesa doble'; /*como se unen*/
 
 /*mostrar cuantas hamburguesas dpble se ha vendido*/
 select sum(vende.cantidad) /*sumar la cantidad de producto vendidos( 4) de LA TABLA VENDE */
 from vende , producto/*que tablas participan*/
 where vende.codigo=producto.codigo and nombre = 'hamburguesa doble';
 
 /*mostrar la cantidad total comprada por joaquin chumacero del producto hamburguesa doble*/
 select sum(vende.cantidad)
 from factura,vende,producto
 where factura.nrof=vende.nrof and vende.codigo=producto.codigo and producto.nombre='hamburguesa doble' and factura.nombre='joaquin chumacero';
 
 /*mostrar el monto total ingresado por la venta de la hamburguesa doble*/
  select sum(cantidad * vende.precio) as totalvendido/*cambio nombre la columna*/
 from vende,producto
 where  vende.codigo=producto.codigo and producto.nombre='hamburguesa doble'; 
 
 
 select *
 from producto;
 
 select *
 from vende;
 
 /* 09/04/2025
 
 /* mostrar todos los productos que no se han vendidio*/
 
 select *
 from producto
 where codigo not in ( select codigo
						from vende
					 );
                     
 select *
 from producto
 where codigo in ( select codigo
						from vende
					 );

select count(vende.nrof)
from vende, producto, categoria
where vende.codigo=producto.codigo and idcat = id and descripcion = 'bebidas';

select *
from descripcion;
                     
