create database OFERTASA;
use OFERTASA;

drop database OFERTASA; /* ESTO BORRA LA BASE DE DATOS*/

create table docente
(
   codigo integer not null primary key,
   nombre VARCHAR(40) not null
);


insert into  docente value(111,'ZUNA VILLAGOMEX RICARDO');
insert into  docente value(222,'VEIZAGA GONZALES JOSUE');
insert into  docente value(333,'CONTRERAS VILLEGAS JUAN CARLOS');

create table materia(
    sigla varchar(6) not null primary key,
    nombre varchar(40) not null
);

insert into materia value('INF110','INTRODUCCION LA INFORMATICA');
insert into materia value('INF312','BASE DE DATOS 1');




create table grupo
(
   id integer not null primary key,
   nombre varchar(2) not null,
   codigo integer not null,
   sigla varchar(6) not null,
   foreign key (codigo) references docente (codigo)
   on delete cascade
   on update cascade,
   foreign key (sigla) references materia (sigla)
   on delete cascade
   on update cascade
);

insert into grupo value(100,'SB',111,'INF110');
insert into grupo value(101,'SZ',333,'INF110');
insert into grupo value(102,'SA',222,'INF312');

create table horario(
   id integer not null primary key,
   dia varchar(20) not null,
   diai varchar(5) not null,
   diaf varchar(5) not null
);

drop table horario;

insert into horario values (1,'lunes','7:00','8:30');
insert into horario values (2,'lunes','8:30','10:00');
insert into horario values (3,'lunes','10:00','11:30');
insert into horario values (4,'miercoles','7:00','8:30');
insert into horario values (5,'miercoles','8:30','10:00');
insert into horario values (6,'miercoles','10:00','11:30');
insert into horario values (7,'viernes','7:00','8:30');
insert into horario values (8,'viernes','8:30','10:00');
insert into horario values (9,'viernes','10:00','11:30');

create table tiene(
   idgrupo integer  not null,
   idhorario integer  not null,
   foreign key (idgrupo) references grupo (id)
   on delete cascade
   on update cascade,
   foreign key (idhorario) references horario (id)
);

 insert into tiene values (100,3);
 insert into tiene values (100,6);
 insert into tiene values (100,9);
 insert into tiene values (101,1);
 insert into tiene values (101,4);
 insert into tiene values (101,7);
 insert into tiene values (102,2);
 insert into tiene values (102,5);
 insert into tiene values (102,8);


select * from docente;
select * from materia;
select * from grupo;
select * from horario;
select * from tiene;





