drop table pessoas cascade constraints;
drop table funcionarios_porto cascade constraints;
drop table distribuidores cascade constraints;
drop table embarcados cascade constraints;
drop table tripulantes cascade constraints;
drop table capitao cascade constraints;
drop table barcos cascade constraints;
drop table tipos_barco cascade constraints;
drop table cais cascade constraints;
drop table terminais cascade constraints;
drop table contentores cascade constraints;
drop table mercadoria cascade constraints;
drop table shipping cascade constraints;
drop table navegacoes cascade constraints;
drop table navega cascade constraints;
drop table atraca cascade constraints;
drop table comanda cascade constraints;
drop table transporta cascade constraints;
drop sequence seq_id_barco;
drop sequence seq_n_nav;

---Create das tabelas---
create table pessoas (
   nif           number(9),
   nome          varchar2(40),
   nacionalidade varchar2(40),
   data_nasc     date not null,
   primary key ( nif )
);

create table funcionarios_porto (
   nif      number(9),
   funcao_p varchar2(40),
   horario  varchar2(20),
   salario  number(7),
   primary key ( nif ),
   foreign key ( nif )
      references pessoas ( nif ),
   constraint ck_horario_valido
      check ( horario in ( 'dia',
                           'noite',
                           'dia_noite' ) )
);

create table distribuidores (
   nif     number(9),
   empresa varchar2(40),
   primary key ( nif ),
   foreign key ( nif )
      references pessoas ( nif )
);

create table embarcados (
   nif     number(9),
   ced_mar number(10),
   primary key ( nif ),
   foreign key ( nif )
      references pessoas ( nif )
);

create table tripulantes (
   nif      number(9),
   funcao_t varchar2(40),
   primary key ( nif ),
   foreign key ( nif )
      references embarcados ( nif )
);

create table capitao (
   nif       number(9),
   n_licenca number(10),
   anos_exp  number(3),
   primary key ( nif ),
   foreign key ( nif )
      references embarcados ( nif )
);

create table tipos_barco (
   tipo        varchar2(40),
   cap_max     number(4),
   comprimento number(10),
   primary key ( tipo )
);

create table barcos (
   id   number(10),
   nome varchar2(40),
   ano  number(4),
   pais varchar2(40),
   tipo varchar2(40),
   primary key ( id ),
   foreign key ( tipo )
      references tipos_barco
);

create table terminais (
   id_terminal     number(5),
   qnt_contentores number(5),
   primary key ( id_terminal )
);

create table cais (
   id_cais     number(5),
   comprimento number(10),
   estado_ocup varchar2(20), --check (estado_ocup in ('Livre', 'Ocupado', 'Manutencao')),
   id_terminal number(5),
   primary key ( id_cais ),
   foreign key ( id_terminal )
      references terminais ( id_terminal )
);

create table contentores (
   n_cont   number(15),
   max_peso number(5), --check ( max_peso > 0 ),
   primary key ( n_cont )
);

create table mercadoria (
   nome_merc varchar2(50),
   tipo      varchar2(30),
   preco     number(10,2),-- check (preco >= 0),
   peso      number(5),-- check (peso > 0),
   primary key ( nome_merc )
);



create table navegacoes (
   n_nav        number(15),
   data_par     date not null,
   data_che     date not null,
   destino      varchar2(50),
   porto_origem varchar2(50),
   id_barco     number(10),
   primary key ( n_nav ),
   foreign key ( id_barco )
      references barcos ( id )
   --check (data_che is null or data_che >= data_par)
);

create table shipping (
   nif       number(9),
   n_pedido  number(15),
   data_lim  date not null,
   nome_merc varchar2(50),
   n_cont    number(5),
   primary key ( nif,
                 n_pedido ),
   foreign key ( nif )
      references distribuidores ( nif ),
   foreign key ( nome_merc )
      references mercadoria ( nome_merc ),
   foreign key ( n_cont )
      references contentores ( n_cont )
);

create table navega (
   nif   number(9),
   n_nav number(15),
   primary key ( nif,
                 n_nav ),
   foreign key ( nif )
      references tripulantes ( nif ),
   foreign key ( n_nav )
      references navegacoes ( n_nav )
);

create table atraca (
   id       number(10),
   data_atr date not null,
   id_cais  number(5),
   primary key ( id,
                 data_atr ),
   foreign key ( id )
      references barcos ( id ),
   foreign key ( id_cais )
      references cais ( id_cais )
);

create table comanda (
   nif   number(9),
   n_nav number(15),
   primary key ( nif,
                 n_nav ),
   foreign key ( nif )
      references capitao ( nif ),
   foreign key ( n_nav )
      references navegacoes ( n_nav )
);

create table transporta (
   n_nav  number(15),
   n_cont number(15),
   primary key ( n_nav,
                 n_cont ),
   foreign key ( n_nav )
      references navegacoes ( n_nav ),
   foreign key ( n_cont )
      references contentores ( n_cont )
);

