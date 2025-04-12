create database OFERTASA;
use OFERTASA;

drop database OFERTASA;

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

create table horario(
   id integer not null primary key,
   dia varchar(8) not null,
   diai varchar(5) not null,
   diaf varchar(5) not null
);

create table tiene(
   idgrupo integer  not null,
   idhorario integer  not null,
   foreign key (idgrupo) references grupo (id)
   on delete cascade
   on update cascade,
   foreign key (idhorario) references horario (id)
);

select *
from docente
where codigo = 111;





