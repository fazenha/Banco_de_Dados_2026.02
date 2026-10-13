-- =====================================================================
-- AULA 09 · LABORATÓRIO · Transações na prática
-- Banco de Dados · Universidade Anhembi Morumbi · Prof. Flávio Copola Azenha
--
-- Três exemplos curtos com o banco biblioteca_v2:
--   1. COMMIT e ROLLBACK
--   2. Erro no meio da transação
--   3. Bloqueio entre duas sessões
-- =====================================================================
--
-- COMO USAR
-- 1. Importar biblioteca_v2.sql (Server > Data Import > Import from
--    Self-Contained File > Start Import).
-- 2. Abrir a mesma conexão duas vezes no Workbench: a primeira aba é a
--    SESSÃO A, e a segunda, a SESSÃO B. Só o exemplo 3 usa a sessão B.
-- 3. Executar um comando por vez, com o cursor sobre ele e Ctrl+Enter.
-- 4. Manter o autocommit ligado (SELECT @@autocommit deve retornar 1).
-- 5. Para repetir o laboratório, importar biblioteca_v2.sql de novo.
-- =====================================================================

-- >>> SESSÃO A
USE biblioteca_v2;

-- ---------------------------------------------------------------------
-- EXEMPLO 1 · COMMIT e ROLLBACK (sessão A)
-- Empréstimo de Torto Arado (livro 1, com 2 exemplares livres) para
-- Isabela (usuário 2).
-- ---------------------------------------------------------------------
-- 1.1 Estado inicial. OBSERVAR: 2 exemplares livres.
SELECT qtd_disponivel FROM livro WHERE pk_livro_id = 1;

-- 1.2 Registrar o empréstimo e dar baixa no exemplar.
START TRANSACTION;
INSERT INTO livro_has_usuario VALUES (1, 2, '2026-10-13', '2026-10-27', NULL);
UPDATE livro SET qtd_disponivel = qtd_disponivel - 1 WHERE pk_livro_id = 1;
-- OBSERVAR: dentro da transação, o livro já aparece com 1 exemplar livre.
SELECT qtd_disponivel FROM livro WHERE pk_livro_id = 1;

-- 1.3 Desfazer. OBSERVAR: o livro volta a 2, e o empréstimo não existe.
ROLLBACK;
SELECT qtd_disponivel FROM livro WHERE pk_livro_id = 1;
SELECT COUNT(*) FROM livro_has_usuario WHERE fk_usuario_id = 2 AND data_devolucao IS NULL;

-- 1.4 Repetir e confirmar. OBSERVAR: agora o livro fica com 1 livre.
START TRANSACTION;
INSERT INTO livro_has_usuario VALUES (1, 2, '2026-10-13', '2026-10-27', NULL);
UPDATE livro SET qtd_disponivel = qtd_disponivel - 1 WHERE pk_livro_id = 1;
COMMIT;
SELECT qtd_disponivel FROM livro WHERE pk_livro_id = 1;
-- EXPLICAÇÃO: ROLLBACK desfaz tudo o que foi feito desde o START
-- TRANSACTION, e COMMIT torna as alterações permanentes. O registro e a
-- baixa acontecem juntos ou não acontecem (atomicidade).

-- ---------------------------------------------------------------------
-- EXEMPLO 2 · Erro no meio da transação (sessão A)
-- Empréstimo de Dom Casmurro (livro 14), que está esgotado.
-- ---------------------------------------------------------------------
-- 2.1 Registrar o empréstimo. O INSERT é aceito.
START TRANSACTION;
INSERT INTO livro_has_usuario VALUES (14, 2, '2026-10-13', '2026-10-27', NULL);

-- 2.2 Dar baixa. OBSERVAR: ERROR 3819 (Check constraint
-- 'ck_livro_disponivel' is violated), porque não há exemplar livre.
UPDATE livro SET qtd_disponivel = qtd_disponivel - 1 WHERE pk_livro_id = 14;

-- 2.3 OBSERVAR: o empréstimo continua registrado. O erro desfez só o
-- UPDATE, e a transação segue aberta.
SELECT * FROM livro_has_usuario WHERE fk_livro_id = 14 AND fk_usuario_id = 2;

-- 2.4 Desfazer. OBSERVAR: o registro desaparece.
ROLLBACK;
SELECT * FROM livro_has_usuario WHERE fk_livro_id = 14 AND fk_usuario_id = 2;
-- EXPLICAÇÃO: no MySQL, um erro desfaz apenas o comando que falhou.
-- Cabe à aplicação executar o ROLLBACK. Um COMMIT nesse ponto gravaria
-- o empréstimo sem a baixa do exemplar.

-- ---------------------------------------------------------------------
-- EXEMPLO 3 · Bloqueio entre duas sessões (sessões A e B)
-- Dois balcões dão baixa no mesmo livro: Ensaio sobre a Cegueira
-- (livro 4).
-- ---------------------------------------------------------------------
-- 3.1 A sessão A dá baixa, sem confirmar (bloqueio X no livro 4).
START TRANSACTION;
UPDATE livro SET qtd_disponivel = qtd_disponivel - 1 WHERE pk_livro_id = 4;

-- >>> SESSÃO B
USE biblioteca_v2;
-- 3.2 Leitura comum. OBSERVAR: B lê 2 na hora, sem esperar, porque o
-- SELECT comum lê a última versão confirmada.
SELECT qtd_disponivel FROM livro WHERE pk_livro_id = 4;

-- 3.3 A sessão B tenta dar baixa no mesmo livro.
-- OBSERVAR: B fica aguardando, e a execução não termina.
START TRANSACTION;
UPDATE livro SET qtd_disponivel = qtd_disponivel - 1 WHERE pk_livro_id = 4;

-- >>> SESSÃO A
-- 3.4 A sessão A desfaz a transação. OBSERVAR: na aba da sessão B, o
-- UPDATE termina na mesma hora.
ROLLBACK;

-- >>> SESSÃO B
-- 3.5 Encerrar a transação da sessão B.
ROLLBACK;
-- EXPLICAÇÃO: o UPDATE pede bloqueio exclusivo (X) na linha, mantido até
-- o COMMIT ou o ROLLBACK. Enquanto isso, outra escrita na mesma linha
-- espera. É assim que o SGBD garante o isolamento, e por isso as
-- transações devem ser curtas.
