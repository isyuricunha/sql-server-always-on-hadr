---CRIA DATABASE 1
CREATE DATABASE PRODUCAO
GO
USE PRODUCAO
--CRIA TABELA
CREATE TABLE LANCAMENTOS 
  (ID_LANCAMENTO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DATA DATETIME NOT NULL,
   QTD FLOAT NOT NULL,
   OBS VARCHAR(10)
   )
   GO
--INSERE REGISTROS
INSERT INTO LANCAMENTOS VALUES (GETDATE(),RAND()*100,'CARGA 1')
GO 1000
--EVIDENCIA INSERT
SELECT COUNT(*) FROM LANCAMENTOS
--FAZ BACKUP
BACKUP DATABASE PRODUCAO TO DISK ='H:/SQL001/PRODUCAO.BAK'

--BANCO EM MODO RECOVERY FULL
USE master
ALTER DATABASE PRODUCAO SET RECOVERY FULL
GO
--CRIANDO DATABASE 2
CREATE DATABASE QUALIDADE
GO
USE QUALIDADE
--CRIA TABELA
CREATE TABLE REGISTROS 
  (ID_REGISTROS INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DATA DATETIME NOT NULL,
   QTD FLOAT NOT NULL,
   OBS VARCHAR(10)
   )
   GO
--INSERE REGISTROS
INSERT INTO REGISTROS VALUES (GETDATE(),RAND()*100,'CARGA 1')
GO 1000
--EVIDENCIA INSERT
SELECT COUNT(*) FROM REGISTROS
--FAZ BACKUP
BACKUP DATABASE QUALIDADE TO DISK ='H:/SQL001/QUALIDADE.BAK'

--BANCO EM MODO RECOVERY FULL
USE master
ALTER DATABASE QUALIDADE SET RECOVERY FULL


--CRIANDO DATABASE 3
CREATE DATABASE FINANCEIRO
GO
USE FINANCEIRO
--CRIA TABELA
CREATE TABLE PAGAMENTOS 
  (ID_PAGTO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DATA DATETIME NOT NULL,
   VALOR FLOAT NOT NULL,
   OBS VARCHAR(10)
   )
   GO
--INSERE REGISTROS
INSERT INTO PAGAMENTOS VALUES (GETDATE(),RAND()*100,'CARGA 1')
GO 1000
--EVIDENCIA INSERT
SELECT COUNT(*) FROM PAGAMENTOS
--FAZ BACKUP
BACKUP DATABASE FINANCEIRO TO DISK ='H:/SQL001/FINANCEIRO.BAK'

--BANCO EM MODO RECOVERY FULL
USE master
ALTER DATABASE FINANCEIRO SET RECOVERY SIMPLE


--CRIANDO DATABASE 4
CREATE DATABASE LOGISTICA
GO
USE LOGISTICA
--CRIA TABELA
CREATE TABLE FRETES 
  (ID_FRETE INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DATA DATETIME NOT NULL,
   VALOR FLOAT NOT NULL,
   OBS VARCHAR(10)
   )
   GO
--INSERE REGISTROS
INSERT INTO FRETES VALUES (GETDATE(),RAND()*100,'CARGA 1')
GO 1000
--EVIDENCIA INSERT
SELECT COUNT(*) FROM FRETES

--SEM BACKUP

--BANCO EM MODO RECOVERY FULL
USE master
ALTER DATABASE LOGISTICA SET RECOVERY SIMPLE

/*DROP DATABASE
DROP DATABASE PRODUCAO
DROP DATABASE LOGISTICA
DROP DATABASE FINANCEIRO
DROP DATABASE QUALIDADE
*/