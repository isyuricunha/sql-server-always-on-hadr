--CRIANDO DATABASE
CREATE DATABASE TESTE
go
USE TESTE
GO
--CRIANDO A TABELA
CREATE TABLE ALUNOS
  (ID INT NULL,
   NOME VARCHAR(50)
   )
--INSERINDO DADOS
INSERT INTO ALUNOS VALUES (1, 'Jack')
INSERT INTO ALUNOS VALUES (2, 'Derek')
INSERT INTO ALUNOS VALUES (3, 'Peter')
INSERT INTO ALUNOS VALUES (4, 'Mary')

--ABRINDO UMA TRANSAÇÃO
USE TESTE
 GO
BEGIN TRAN
	UPDATE ALUNOS SET NOME = 'Paul' WHERE ID = 3
--Checkpoint é o processo interno da engine SQL Server responsável pela 
--operação de gravação das transações/dados nos disco físico (arquivos .mdf e .ndf). 
--É ele o mecanismo que cria o chamado ponto de verificação e grava as paginas 
--com alterações de dados (Dirty Page) contidas no Transaction Log (.ldf) 
--nos arquivos de dados (Data files .mdf e .ndf).
CHECKPOINT

--Abra o Gerenciador de Tarefas e encerre o processo do SQL Server, 
--com isso iremos simular um crash no servidor
USE Master
GO
-- Coloca o database em modo de emergência
ALTER DATABASE TESTE SET EMERGENCY
GO
-- Realiza um check do database
DBCC CHECKDB('TESTE')
GO
-- Altera o database para SINGLE_USER, ou seja, só um usuário pode estar conectado
ALTER DATABASE TESTE SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
-- Realiza o comando para reparo do database
DBCC CHECKDB('TESTE', REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS, ALL_ERRORMSGS
GO
DBCC CHECKDB('TESTE', REPAIR_REBUILD) WITH NO_INFOMSGS, ALL_ERRORMSGS
GO


-- Volta a base de dados para multiplos usuários
ALTER DATABASE TESTE SET MULTI_USER
GO
-- Restarta o status do database
EXEC sp_resetstatus 'TESTE'

use TESTE
go
SELECT * FROM ALUNOS