--Triggers--

--Para quando um barco atraca (inser em atraca)
create or replace trigger atualiza_atraca_entrada after
   insert on atraca
   for each row
begin
   update cais
      set
      estado_ocup = 'Ocupado'
    where id_cais = :new.id_cais;
end;
/

--Para quando um barco desatraca (delete em atraca)
create or replace trigger atualiza_atraca_saida after
   delete on atraca
   for each row
begin
   update cais
      set
      estado_ocup = 'Livre'
    where id_cais = :old.id_cais;
end;
/

--Function que indica se um barco pode atracar num dado cais

create or replace function fn_pode_atracar (
   v_id_barco in number,
   v_id_cais  in number
) return varchar2 is
   comp_barco number;
   comp_cais  number;
   estado     varchar2(40);
begin
   -- Obter comprimento do barc
   select comprimento
     into comp_barco
     from barcos
    inner join tipos_barco
   using ( tipo )
    where id = v_id_barco;

   -- pegar comprimento e estado do cais
   select comprimento,
          estado_ocup
     into
      comp_cais,
      estado
     from cais
    where id_cais = v_id_cais;


   if estado != 'Livre' then
      return 'Não: Cais ocupado';
   elsif comp_barco > comp_cais then
      return 'Não: Barco demasiado grande para este cais';
   else
      return 'Sim: Atracamento autorizado';
   end if;

exception
   when no_data_found then
      return 'ERRO de parametros: barco ou cais inexistente';
end;
/


-- Esta solucao para triggers de ocupaçao nao permite a consulta de historico, para consultar o historico deviamos usar compound triggers

create or replace trigger trg_valida_atracamento before
   insert on atraca
   for each row
declare
   v_verificacao varchar(100);
begin
   v_verificacao := fn_pode_atracar(
      :new.id,
      :new.id_cais
   );
   if v_verificacao not like 'Sim%' then
      raise_application_error(
         -20005,
         v_verificacao
      );
   end if;
end;
/



--Trigger para o peso maximo de cada mercadoria

create or replace trigger trg_valida_peso before
   insert or update on shipping
   for each row
declare
   peso_mercadoria number;
   peso_contentor  number;
begin
   select peso
     into peso_mercadoria
     from mercadoria
    where nome_merc = :new.nome_merc;

   select max_peso
     into peso_contentor
     from contentores
    where n_cont = :new.n_cont;

   if peso_mercadoria > peso_contentor then
      raise_application_error(
         -20101,
         'Erro de carga: mercadoria mais pesada que o contentor de transporte'
      );
   end if;
end;
/

--Trigger que valida as datas das navegaçoes

create or replace trigger trg_valida_datas before
   insert or update on navegacoes
   for each row
begin
   if
      :new.data_che is not null
      and :new.data_che < :new.data_par
   then
      raise_application_error(
         -20105,
         'Erro cronológico: data de chegada não pode ser anterior à de partida'
      );
   end if;
end;
/

create or replace function func_capacity_restante (
   p_n_cont in number
) return number is
   v_max_peso   number;
   v_peso_atual number;
begin
   select max_peso
     into v_max_peso
     from contentores
    where n_cont = p_n_cont;

   select nvl(
      sum(m.peso),
      0
   )
     into v_peso_atual
     from shipping s
     join mercadoria m
   on s.nome_merc = m.nome_merc
    where s.n_cont = p_n_cont;

   return v_max_peso - v_peso_atual;
end;
/

create sequence seq_id_barco start with 50 increment by 1;

create or replace trigger trg_id_barco before
   insert on barcos
   for each row
begin
   select seq_id_barco.nextval
     into :new.id
     from dual;
end;
/
--adicionar numero das navegaçoes automaticamente
create sequence seq_n_nav start with 400 increment by 1;

create or replace trigger tgr_n_nav before
   insert on navegacoes
   for each row
begin
   select seq_n_nav.nextval
     into :new.n_nav
     from dual;
end;
/
