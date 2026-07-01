-- PESSOAS
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (111111111, 'João Neves', 'Portuguesa', TO_DATE('1985-04-12', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (222222222, 'Maria Silva', 'Portuguesa', TO_DATE('1990-08-25', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (333333333, 'Carlos Santos', 'Brasileira', TO_DATE('1975-11-03', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (444444444, 'Ana Oliveira', 'Espanhola', TO_DATE('1992-01-30', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (555555555, 'Pedro Costa', 'Portuguesa', TO_DATE('1988-07-15', 'YYYY-MM-DD'));

-- TIPOS_BARCO
INSERT INTO tipos_barco (tipo, cap_max, comprimento) VALUES ('Cargueiro', 500, 250);
INSERT INTO tipos_barco (tipo, cap_max, comprimento) VALUES ('Petroleiro', 200, 300);
INSERT INTO tipos_barco (tipo, cap_max, comprimento) VALUES ('Rebocador', 0, 30);

-- TERMINAIS
INSERT INTO terminais (id_terminal, qnt_contentores) VALUES (10, 5000);
INSERT INTO terminais (id_terminal, qnt_contentores) VALUES (20, 3500);

-- CONTENTORES
INSERT INTO contentores (n_cont, max_peso) VALUES (1001, 25000);
INSERT INTO contentores (n_cont, max_peso) VALUES (1002, 25000);
INSERT INTO contentores (n_cont, max_peso) VALUES (1003, 30000);

-- MERCADORIA
INSERT INTO mercadoria (nome_merc, tipo, preco, peso) VALUES ('Bananas', 'Alimentar', 1.50, 10000);
INSERT INTO mercadoria (nome_merc, tipo, preco, peso) VALUES ('Computadores', 'Eletronica', 850.00, 5000);
INSERT INTO mercadoria (nome_merc, tipo, preco, peso) VALUES ('Algodao', 'Textil', 3.20, 15000);

-- FUNCIONARIOS_PORTO (Depende de Pessoas)
INSERT INTO funcionarios_porto (nif, funcao_p, horario, salario) VALUES (111111111, 'Operador de Grua', 'dia', 1250);

-- DISTRIBUIDORES (Depende de Pessoas)
INSERT INTO distribuidores (nif, empresa) VALUES (222222222, 'Logistica PT Lda');

-- EMBARCADOS (Depende de Pessoas)
INSERT INTO embarcados (nif, ced_mar) VALUES (333333333, 99001);
INSERT INTO embarcados (nif, ced_mar) VALUES (444444444, 99002);
INSERT INTO embarcados (nif, ced_mar) VALUES (555555555, 99003);

-- BARCOS (Depende de Tipos_Barco - IDs começam no 50)
INSERT INTO barcos (id, nome, ano, pais, tipo) VALUES (50, 'Mar Azul', 2015, 'Portugal', 'Cargueiro');
INSERT INTO barcos (id, nome, ano, pais, tipo) VALUES (51, 'Oceano Negro', 2010, 'Panamá', 'Petroleiro');

-- CAIS (Depende de Terminais)
INSERT INTO cais (id_cais, comprimento, estado_ocup, id_terminal) VALUES (101, 300, 'Livre', 10);
INSERT INTO cais (id_cais, comprimento, estado_ocup, id_terminal) VALUES (102, 350, 'Livre', 20);


-- CAPITAO (Depende de Embarcados)
INSERT INTO capitao (nif, n_licenca, anos_exp) VALUES (333333333, 55001, 15);

-- TRIPULANTES (Depende de Embarcados)
INSERT INTO tripulantes (nif, funcao_t) VALUES (444444444, 'Mecânica');
INSERT INTO tripulantes (nif, funcao_t) VALUES (555555555, 'Marinheiro');

-- NAVEGACOES (Depende de Barcos - n_nav começa no 400)
INSERT INTO navegacoes (n_nav, data_par, data_che, destino, porto_origem, id_barco) 
VALUES (400, TO_DATE('2026-06-01', 'YYYY-MM-DD'), TO_DATE('2026-06-15', 'YYYY-MM-DD'), 'Roterdão', 'Sines', 50);

INSERT INTO navegacoes (n_nav, data_par, data_che, destino, porto_origem, id_barco) 
VALUES (401, TO_DATE('2026-07-10', 'YYYY-MM-DD'), TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'Nova Iorque', 'Leixões', 50);

-- SHIPPING (Depende de Distribuidores, Mercadoria, Contentores)
INSERT INTO shipping (nif, n_pedido, data_lim, nome_merc, n_cont) 
VALUES (222222222, 50001, TO_DATE('2026-06-20', 'YYYY-MM-DD'), 'Bananas', 1001);

INSERT INTO shipping (nif, n_pedido, data_lim, nome_merc, n_cont) 
VALUES (222222222, 50002, TO_DATE('2026-06-25', 'YYYY-MM-DD'), 'Computadores', 1002);

-- COMANDA (Depende de Capitao, Navegacoes)
INSERT INTO comanda (nif, n_nav) VALUES (333333333, 400);
INSERT INTO comanda (nif, n_nav) VALUES (333333333, 401);

-- NAVEGA (Depende de Tripulantes, Navegacoes)
INSERT INTO navega (nif, n_nav) VALUES (444444444, 400);
INSERT INTO navega (nif, n_nav) VALUES (555555555, 400);

-- ATRACA (Depende de Barcos, Cais)
INSERT INTO atraca (id, data_atr, id_cais) VALUES (50, TO_DATE('2026-05-28', 'YYYY-MM-DD'), 101);
INSERT INTO atraca (id, data_atr, id_cais) VALUES (51, TO_DATE('2026-05-29', 'YYYY-MM-DD'), 102);

-- TRANSPORTA (Depende de Navegacoes, Contentores)
INSERT INTO transporta (n_nav, n_cont) VALUES (400, 1001);
INSERT INTO transporta (n_nav, n_cont) VALUES (400, 1002);

COMMIT;


-- PESSOAS (Novos NIFs)
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (666666666, 'Rui Mendes', 'Portuguesa', TO_DATE('1982-10-05', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (777777777, 'Sofia Lima', 'Portuguesa', TO_DATE('1979-03-21', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (888888888, 'Tiago Rocha', 'Cabo-Verdiana', TO_DATE('1995-12-11', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (999999999, 'Inês Martins', 'Portuguesa', TO_DATE('1993-06-18', 'YYYY-MM-DD'));
INSERT INTO pessoas (nif, nome, nacionalidade, data_nasc) VALUES (101010101, 'Lucas Fernandes', 'Brasileira', TO_DATE('1970-02-28', 'YYYY-MM-DD'));

-- TIPOS_BARCO (Novos Tipos)
INSERT INTO tipos_barco (tipo, cap_max, comprimento) VALUES ('Porta-Contentores', 800, 350);
INSERT INTO tipos_barco (tipo, cap_max, comprimento) VALUES ('Graneleiro', 400, 220);

-- TERMINAIS (Novos Terminais)
INSERT INTO terminais (id_terminal, qnt_contentores) VALUES (30, 4000);
INSERT INTO terminais (id_terminal, qnt_contentores) VALUES (40, 2000);

-- CONTENTORES (Novos Contentores)
INSERT INTO contentores (n_cont, max_peso) VALUES (1004, 28000);
INSERT INTO contentores (n_cont, max_peso) VALUES (1005, 32000);

-- MERCADORIA (Novas Mercadorias)
INSERT INTO mercadoria (nome_merc, tipo, preco, peso) VALUES ('Carros', 'Automovel', 25000.00, 12000);
INSERT INTO mercadoria (nome_merc, tipo, preco, peso) VALUES ('Cafe', 'Alimentar', 4.50, 18000);


-- 2. TABELAS DEPENDENTES DE 1º NÍVEL

-- FUNCIONARIOS_PORTO
INSERT INTO funcionarios_porto (nif, funcao_p, horario, salario) VALUES (666666666, 'Inspetor de Carga', 'noite', 1400);

-- DISTRIBUIDORES
INSERT INTO distribuidores (nif, empresa) VALUES (777777777, 'Global Cargo Lda');

-- EMBARCADOS
INSERT INTO embarcados (nif, ced_mar) VALUES (888888888, 99004);
INSERT INTO embarcados (nif, ced_mar) VALUES (999999999, 99005);
INSERT INTO embarcados (nif, ced_mar) VALUES (101010101, 99006);

-- BARCOS (IDs a continuar do script anterior: 52 e 53)
INSERT INTO barcos (id, nome, ano, pais, tipo) VALUES (52, 'Vento do Norte', 2018, 'Portugal', 'Porta-Contentores');
INSERT INTO barcos (id, nome, ano, pais, tipo) VALUES (53, 'Estrela Polar', 2020, 'Noruega', 'Graneleiro');

-- CAIS
INSERT INTO cais (id_cais, comprimento, estado_ocup, id_terminal) VALUES (103, 400, 'Livre', 30);
INSERT INTO cais (id_cais, comprimento, estado_ocup, id_terminal) VALUES (104, 250, 'Livre', 40);


-- 3. TABELAS DEPENDENTES DE 2º NÍVEL E NAVEGAÇÕES

-- CAPITAO
INSERT INTO capitao (nif, n_licenca, anos_exp) VALUES (101010101, 55004, 20);

-- TRIPULANTES
INSERT INTO tripulantes (nif, funcao_t) VALUES (888888888, 'Cozinheiro');
INSERT INTO tripulantes (nif, funcao_t) VALUES (999999999, 'Imediato');

-- NAVEGACOES (n_nav a continuar do script anterior: 402 e 403)
INSERT INTO navegacoes (n_nav, data_par, data_che, destino, porto_origem, id_barco) 
VALUES (402, TO_DATE('2026-08-01', 'YYYY-MM-DD'), TO_DATE('2026-08-12', 'YYYY-MM-DD'), 'Santos', 'Sines', 52);

INSERT INTO navegacoes (n_nav, data_par, data_che, destino, porto_origem, id_barco) 
VALUES (403, TO_DATE('2026-08-15', 'YYYY-MM-DD'), TO_DATE('2026-08-25', 'YYYY-MM-DD'), 'Hamburgo', 'Leixões', 53);


-- 4. TABELAS DE LIGAÇÃO E HISTÓRICO (M:N)


-- SHIPPING
INSERT INTO shipping (nif, n_pedido, data_lim, nome_merc, n_cont) 
VALUES (777777777, 50003, TO_DATE('2026-08-10', 'YYYY-MM-DD'), 'Carros', 1004);

INSERT INTO shipping (nif, n_pedido, data_lim, nome_merc, n_cont) 
VALUES (777777777, 50004, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'Cafe', 1005);

-- COMANDA
INSERT INTO comanda (nif, n_nav) VALUES (101010101, 402);
INSERT INTO comanda (nif, n_nav) VALUES (101010101, 403);

-- NAVEGA
INSERT INTO navega (nif, n_nav) VALUES (888888888, 402);
INSERT INTO navega (nif, n_nav) VALUES (999999999, 403);

-- ATRACA
INSERT INTO atraca (id, data_atr, id_cais) VALUES (52, TO_DATE('2026-07-28', 'YYYY-MM-DD'), 103);
INSERT INTO atraca (id, data_atr, id_cais) VALUES (53, TO_DATE('2026-08-12', 'YYYY-MM-DD'), 104);

-- TRANSPORTA
INSERT INTO transporta (n_nav, n_cont) VALUES (402, 1004);
INSERT INTO transporta (n_nav, n_cont) VALUES (403, 1005);

COMMIT;
