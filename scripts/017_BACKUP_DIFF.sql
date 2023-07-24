
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
BACKUP DATABASE AULA_BK TO DISK='M:\SQL001\AULA_BK-FULL.BAK' WITH STATS
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


--Passo 6
--Verificando registros
SELECT COUNT(*) FROM REGISTROS
�

--Passo 7
--Criando Backup com Arquivos de DIFFERENTIAL
BACKUP DATABASE AULA_BK TO DISK = 'M:\SQL001\AULA_BK-DIFF1.BAK' WITH DIFFERENTIAL


--Passo 8
--Inserindo mais registros
INSERT INTO REGISTROS VALUES ('2 CARGA')
GO 1000
�
--Passo 9
----Criando Backup com Arquivos de DIFFERENTIAL
BACKUP DATABASE AULA_BK TO DISK = 'M:\SQL001\AULA_BK-DIFF2.BAK'  WITH DIFFERENTIAL

�
--Passo 10
--Inserindo mais registros
INSERT INTO REGISTROS VALUES ('3 CARGA')
GO 1000
�
--Passo 11
----Criando Backup com Arquivos de DIFFERENTIAL
BACKUP DATABASE AULA_BK TO DISK = 'M:\SQL001\AULA_BK-DIFF3.BAK'  WITH DIFFERENTIAL


--Passo 12
--Verificando
USE AULA_BK
SELECT COUNT(*),CARGA CARGA FROM REGISTROS
GROUP BY CARGA
�
�
--Passo 13
--Apagando REGISTROS
USE AULA_BK
GO
DELETE FROM REGISTROS 

--Passo 14
--Verifica as marcas de LSN do segundo Backup FULL
--n�meros de sequ�ncia de log = LSN
RESTORE HEADERONLY FROM DISK = 'M:\SQL001\AULA_BK-FULL.BAK'
RESTORE HEADERONLY FROM DISK = 'M:\SQL001\AULA_BK-DIFF1.BAK'
RESTORE HEADERONLY FROM DISK = 'M:\SQL001\AULA_BK-DIFF2.BAK'
RESTORE HEADERONLY FROM DISK = 'M:\SQL001\AULA_BK-DIFF3.BAK'

--Passo 15
--Restauracao FULL 1 BAK
USE MASTER
GO
RESTORE DATABASE  AULA_BK FROM DISK='M:\SQL001\AULA_BK-FULL.BAK' 
WITH  NORECOVERY,STATS
GO

--PASSO 16
--BACKUP LOG
BACKUP LOG AULA_BK TO DISK='M:\SQL001\AULA_BK-LOG1.TRN'

--PASSO 17
--Restauracao FULL 1 BAK
USE MASTER
GO
RESTORE DATABASE  AULA_BK FROM DISK='M:\SQL001\AULA_BK-FULL.BAK' 
WITH  NORECOVERY,REPLACE, STATS
--STOPAT --PARA EM 
GO

--Passo 18
--Restauracao 3� DIFF
RESTORE DATABASE AULA_BK FROM DISK='M:\SQL001\AULA_BK-DIFF3.BAK' 
 WITH  NORECOVERY,REPLACE, STATS


--Passo 19
--Restauracao 3� lOG
--PASSO 21 DISPONIBILIZA O DB
USE MASTER
GO
RESTORE DATABASE AULA_BK WITH RECOVERY

--Passo 22
--Verificando dados
USE AULA_BK
SELECT COUNT(*), CARGA FROM REGISTROS
GROUP BY CARGA