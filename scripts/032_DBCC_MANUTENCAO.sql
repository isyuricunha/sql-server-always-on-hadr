--Link apoio https://msdn.microsoft.com/pt-br/library/ms188796(v=sql.120).aspx

--Recupera o espaço de colunas de comprimento variável descartadas 
--em tabelas ou exibições indexadas.
DBCC CLEANTABLE (CURSO,PESSOA)  
WITH NO_INFOMSGS; 
--VERIFICANDO A TABELA
USE CURSO
SELECT * FROM PESSOA

--Reduz o tamanho dos arquivos de dados e de log do banco de dados especificado.
--PERMITE 10% ESPACO LIVRE
DBCC SHRINKDATABASE (CURSO, 10);  
--seguir reduz os arquivos de dados e de log no banco de dados de exemplo 
--até a última extensão atribuída.
DBCC SHRINKDATABASE (CURSO, TRUNCATEONLY);
--As tabelas do sistema de banco de dados são verificadas nessa fase.

--Reduz o tamanho do arquivo de log ou dos dados 
USE CURSO;  
GO  
--REDUZ ARQUIVO DE LOG PARA 10 MB
DBCC SHRINKFILE (CURSO_log, 10);  
GO  

--Fornece estatísticas de uso do espaço do log de transações para todos os bancos de dados
DBCC SQLPERF(LOGSPACE);  
GO
--https://docs.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql?view=sql-server-2017#examples
--Gera um clone somente de esquema de um banco de dados usando--
DBCC CLONEDATABASE (CURSO, CURSO_CLONE_1); 
GO 

USE CURSO_CLONE_1
SELECT * FROM PESSOA
--
--Gera um clone somente de esquema de um banco de dados usando SEM ESTATISTICAS
DBCC CLONEDATABASE (CURSO, CURSO_CLONE_2) WITH NO_STATISTICS;    
GO 

--Limpa cache de procedures
DBCC FREEPROCCACHE

--
--Para reiniciar a numeração de uma coluna Identiy de uma tabela do SQL Server, utilize o comando:
DBCC CHECKIDENT('TAB_3', RESEED, 0)

--CRIANDO TABELA
USE CURSO
CREATE TABLE TAB_3
   (ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NOME VARCHAR(10)
	)
--INSERE REGISTROS
INSERT INTO TAB_3 VALUES ('A')
INSERT INTO TAB_3 VALUES ('B')

--VERIFICA REGISTROS 
SELECT * FROM TAB_3

--DELETE FROM REGISTROS
DELETE FROM TAB_3

--INSERINDO NOVOS REGISTROS
INSERT INTO TAB_3 VALUES ('C')
INSERT INTO TAB_3 VALUES ('D')

--VERIFICA REGISTROS 
SELECT * FROM TAB_3

--DELETE FROM REGISTROS
DELETE FROM TAB_3
--REINICIA CHAVE
DBCC CHECKIDENT('TAB_3', RESEED, 0)--REINICIA DO 0
DBCC CHECKIDENT('TAB_3', RESEED, 10)--REINICIA DO 10
