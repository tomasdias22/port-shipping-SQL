--VIEWS importantes

create or replace view v_atracagens as
   select nome,
          tipo,
          data_atr,
          id_cais,
          id_terminal
     from atraca
    inner join barcos
   using ( id )
    inner join cais
   using ( id_cais )
    inner join terminais
   using ( id_terminal );

create or replace view v_pessoas_porto as
   select nome,
          nacionalidade,
          funcao_p,
          horario,
          salario
     from pessoas
    inner join funcionarios_porto
   using ( nif );

create or replace view v_inventario_shipping as
   select empresa,
          n_pedido,
          nome_merc,
          tipo,
          peso,
          n_cont,
          max_peso,
          func_capacity_restante(n_cont) as espaco_livre
     from shipping
    inner join distribuidores
   using ( nif )
    inner join mercadoria
   using ( nome_merc )
    inner join contentores
   using ( n_cont );

create or replace view v_gestao_navegacoes as
   select n_nav,
          barcos.nome as nome_barco,
          tipo,
          pessoas.nome as nome_capitao,
          porto_origem,
          destino,
          data_par,
          data_che
     from navegacoes
    inner join barcos
   on ( id_barco = id )
    inner join comanda
   using ( n_nav )
    inner join pessoas
   using ( nif );

create or replace view v_estado_contentores as
   select n_cont,
          max_peso,
          func_capacity_restante(n_cont) as espaco_livre
     from contentores;
