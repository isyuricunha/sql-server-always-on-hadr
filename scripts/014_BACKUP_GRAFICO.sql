--CRIANDO BANCO DE DADOS PARA AULA DE BACKUP E RESTORE MODO GR�FICO
CREATE DATABASE AULA_BK
GO
USE  AULA_BK
GO

--VERIFICAR O TIPO DE RECUPERA��O DO BANCO DE DADOS
SELECT a.name,a.user_access_desc,a.state_desc,recovery_model_desc 
FROM sys.databases a

--ALTERAR O MODO DE BACKUP PARA FULL
ALTER DATABASE AULA_BK SET RECOVERY FULL;  

-- FAZER BACKUP FULL GR�FICO

--CRIAR TABELA
CREATE TABLE ALUNOS
    (ID_ALUNO INT NOT NULL PRIMARY KEY,
	 NOME VARCHAR(50)
	 );

--INSERINDO DADOS
INSERT INTO ALUNOS VALUES (1,'Jack')
INSERT INTO ALUNOS VALUES (2,'Derek')
-- FAZER BACKUP LOG GR�FICO

--REALIZAR O RESTORE GR�FICO FULLL -MODE RESTORING
--ANALISAR
--REALIZAR O RESTORE GR�FICO DE LOG -MODE STAND BY/READ
--ANALISAR

select * from AULA_BK.dbo.ALUNOS

--ALTERAR STATUS DO BANCO
USE master;  
GO  

ALTER DATABASE AULA_BK SET ONLINE

USE master;  
GO  
--COLOCANDO DATABASE DISPONIVEL 
RESTORE DATABASE AULA_BK WITH RECOVERY

