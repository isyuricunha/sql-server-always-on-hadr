--Passo 1
--Criando Banco de dados
--DROP DATABASE AULA_BK
USE MASTER
CREATE DATABASE AULA_BK
 ON  PRIMARY 
( 
  NAME = N'AULA_BK1', FILENAME = N'k:\SQL001\AULA_BK1.mdf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  ),
  FILEGROUP AULA
  (
  NAME = N'AULA_BK2', FILENAME = N'k:\SQL001\AULA_BK2.ndf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  ),
   (
  NAME = N'AULA_BK3', FILENAME = N'k:\SQL001\AULA_BK3.ndf' , 
  SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
  )
 LOG ON 
( NAME = N'AULA_BK_log', FILENAME = N'L:\SQL001\AULA_BK_log.ldf' , 
  SIZE = 1072KB , MAXSIZE = 2048MB , FILEGROWTH = 10%)

�
--Passo 2 
--Alterando modo de recuperacao
ALTER DATABASE AULA_BK SET RECOVERY FULL
�
--Passo 3
--Realizando 1 Backup
BACKUP DATABASE AULA_BK TO DISK='M:\SQL001\AULA_BK-FULL.BAK'
GO 

--Passo 4
--Criando tabela ALunos
--DROP TABLE ALUNOS
USE AULA_BK
CREATE TABLE REGISTROS (
	ID_REGISTRO INT IDENTITY(1,1)PRIMARY KEY,
	CARGA VARCHAR (50),	
)ON AULA
GO

--Passo 5
--Populando Tabela COM 1000 REGISTRO
INSERT INTO REGISTROS VALUES ('1 CARGA')
GO 1000

--USE MASTER
--ADICIONANDO ARQUIVO DE DADOS
ALTER DATABASE AULA_BK
ADD FILE
(
NAME ='AULA_BK4',                              
FILENAME = N'k:\SQL001\AULA_BK4.ndf' ,
   SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB 
)
TO FILEGROUP AULA

--Passo 6
--Verificando registros
SELECT COUNT(*) FROM REGISTROS
�

--Passo 7
--Criando Backup com Arquivos de Log
BACKUP LOG AULA_BK TO DISK = 'M:\SQL001\AULA_BK-LOG1.TRN'


--Passo 8
--Inserindo mais registros
INSERT INTO REGISTROS VALUES ('2 CARGA')
GO 1000
�
--Passo 9
----Criando Backup com Arquivos de Log
BACKUP LOG AULA_BK TO DISK = 'M:\SQL001\AULA_BK-LOG2.TRN'

�
--Passo 10
--Inserindo mais registros
INSERT INTO REGISTROS VALUES ('3 CARGA')
GO 1000
�
--Passo 11
----Criando Backup com Arquivos de Log
BACKUP LOG AULA_BK TO DISK = 'M:\SQL001\AULA_BK-LOG3.TRN'


--Passo 12
--Verificando
USE AULA_BK
SELECT COUNT(*),CARGA CARGA FROM REGISTROS
GROUP BY CARGA
�
�
--Passo 13
--Apagando Banco de dados
USE MASTER
GO
DROP DATABASE AULA_BK


--Passo 14
--Restauracao FULL 1 BAK
RESTORE DATABASE  AULA_BK FROM DISK='M:\SQL001\AULA_BK-FULL.BAK' 
WITH  STANDBY = N'M:\SQL001\AULA_BK_RollbackUndo_0.bak', 
STATS
GO

--OPCIONAL COM NORECOVERY
--RESTORE DATABASE  AULA_BK FROM DISK='M:\SQL001\AULA_BK-FULL.BAK' 
--WITH  NORECOVERY,STATS


--Passo 15
--Restauracao 1� lOG
RESTORE DATABASE AULA_BK FROM DISK='M:\SQL001\AULA_BK-LOG1.TRN' 
WITH  STANDBY = N'M:\SQL001\AULA_BK_RollbackUndo_1.bak', STATS
--WITH NORECOVERY, STATS


--Passo 16
--Verificando
USE AULA_BK
SELECT COUNT(*), CARGA FROM REGISTROS
GROUP BY CARGA

--Passo 17
--Restauracao 2� lOG
USE MASTER
GO
RESTORE DATABASE AULA_BK FROM DISK='M:\SQL001\AULA_BK-LOG2.TRN' 
WITH  STANDBY = N'M:\SQL001\AULA_BK_RollbackUndo_2.bak', STATS
--WITH NORECOVERY, STATS

--Passo 18
--Verificando
USE AULA_BK
SELECT COUNT(*), CARGA FROM REGISTROS
GROUP BY CARGA


--Passo 19
--Restauracao 3� lOG
USE MASTER
GO
RESTORE DATABASE AULA_BK FROM DISK='M:\SQL001\AULA_BK-LOG3.TRN' 
WITH  STANDBY = N'M:\SQL001\AULA_BK_RollbackUndo_3.bak', STATS
--WITH NORECOVERY, STATS
GO

--Passo 20
--Verificando
USE AULA_BK
SELECT COUNT(*), CARGA FROM REGISTROS
GROUP BY CARGA

--PASSO 21 DISPONIBILIZA O DB
USE MASTER
GO
RESTORE DATABASE AULA_BK WITH RECOVERY

--Passo 22
--Verificando dados
USE AULA_BK
SELECT COUNT(*), CARGA FROM REGISTROS
GROUP BY CARGA