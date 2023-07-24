
-- PARA ALTERAR O PARAMETROS CASO NECESSARIO
USE [master]
GO
ALTER DATABASE [CURSO] SET AUTO_CREATE_STATISTICS ON --ON OU OFF
GO
ALTER DATABASE [CURSO] SET AUTO_UPDATE_STATISTICS OFF WITH NO_WAIT  --ON OU OFF
GO
ALTER DATABASE [CURSO] SET AUTO_UPDATE_STATISTICS_ASYNC ON WITH NO_WAIT  --ON OU OFF
GO
--CRIANDO UMA TABELA PARA TESTE NA BASE CURSO 

USE CURSO
SELECT A.BusinessEntityID ID_PESSOA,
       A.PersonType TIPO_PESSOA, 
	   A.Title Titulo,
	   A.FirstName PRIMEIRO_NOME,
	   A.MiddleName NOME_MEIO,
	   A.LastName ULTIMO_NOME
	   --CRIANDO TABELA PESSOA EM TEMPO DE EXECUCAO
	    INTO PESSOA
	   FROM AdventureWorks2017.Person.Person A

--Verificando se existe estat�sticas em uma tabela
USE CURSO
EXEC sp_helpstats 'PESSOA', 'all'

--Ao executar o Select, teoricamente for�ar� o SQL Server a ]
--criar um plano de execu��o e como n�o existe nenhuma estat�stica 
--para a tabela, internamente e automaticamente ser� criada para o predicado.
--EXEMPLO 1
select * from PESSOA
where PRIMEIRO_NOME like ('A%')

--EXEMPLO 2

select * from PESSOA
where NOME_MEIO like ('A%')

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'PESSOA', 'all'

--verificando tabela de estatisticas
SELECT * FROM sys.stats 
WHERE object_id = OBJECT_ID('PESSOA')

--Estat�sticas criadas implicitamente
--� quando criamos um �ndice � seja ele clustered ou n�o � 
--e por consequ�ncia s�o criadas estat�sticas implicitamente para os 
--campos chaves do �ndice.

ALTER TABLE PESSOA
ADD CONSTRAINT pk_ID PRIMARY KEY CLUSTERED (ID_PESSOA)

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'PESSOA', 'all'

--Estat�sticas cridas manualmente
--Tamb�m podemos cri�-las manualmente, utilizando o comando CREATE STATISTICS

CREATE STATISTICS St_id_nome_1
ON PESSOA (ULTIMO_NOME);

CREATE STATISTICS St_id_nome_2
ON PESSOA (Titulo,ULTIMO_NOME);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'PESSOA', 'all'

--verificando tabela de estatisticas
SELECT * FROM sys.stats 
WHERE object_id = OBJECT_ID('PESSOA')


--Atualizando estat�sticas de uma tabela
UPDATE STATISTICS PESSOA


--apagando statistics
--DROP STATISTICS tabela.nome_stats
DROP STATISTICS PESSOA.St_id_nome_2

--Atualizando estat�stica do banco todo
USE CURSO
GO
sp_updatestats

--RECOMENDADO JANELA PARA EXECUTAR