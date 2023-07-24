--Link apoio https://msdn.microsoft.com/pt-br/library/ms188796(v=sql.120).aspx
USE CURSO
DBCC HELP (PROCCACHE)
DBCC HELP (OPENTRAN)
DBCC HELP (SHOWCONTIG)
DBCC HELP (SHOW_STATISTICS)

--Exibe informa��es de fragmenta��o para os dados e �ndices da tabela ou exibi��o 
--especificada
DBCC SHOWCONTIG (PESSOA)

--UPDATE ESTATISTICS
UPDATE STATISTICS PESSOA
--Exibe as estat�sticas de otimiza��o de consulta atuais de uma tabela ou exibi��o indexada
--https://docs.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-show-statistics-transact-sql?view=sql-server-2017
DBCC SHOW_STATISTICS (PESSOA,PK_ID)
DBCC SHOW_STATISTICS (PESSOA,PK_ID)WITH HISTOGRAM
--19972
DBCC SHOW_STATISTICS (PESSOA,St_id_nome_1)
DBCC SHOW_STATISTICS (PESSOA,St_id_nome_1)WITH HISTOGRAM

DBCC SHOW_STATISTICS (PESSOA,St_id_nome_2)
DBCC SHOW_STATISTICS (PESSOA,St_id_nome_2)WITH HISTOGRAM

--Exibe informa��es em um formato de tabela sobre o cache de procedimento
DBCC PROCCACHE

--Ajuda a identificar as transa��es ativas que podem impedir o truncamento do log
BEGIN TRAN
UPDATE PESSOA SET ULTIMO_NOME='X' WHERE ID_PESSOA='1'
DBCC OPENTRAN (CURSO)
ROLLBACK

