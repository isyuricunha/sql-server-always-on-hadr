
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

--Verificando se existe estatísticas em uma tabela
USE CURSO
EXEC sp_helpstats 'PESSOA', 'all'

--Ao executar o Select, teoricamente forçará o SQL Server a ]
--criar um plano de execução e como não existe nenhuma estatística 
--para a tabela, internamente e automaticamente será criada para o predicado.
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

--Estatísticas criadas implicitamente
--É quando criamos um índice – seja ele clustered ou não – 
--e por consequência são criadas estatísticas implicitamente para os 
--campos chaves do índice.

ALTER TABLE PESSOA
ADD CONSTRAINT pk_ID PRIMARY KEY CLUSTERED (ID_PESSOA)

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'PESSOA', 'all'

--Estatísticas cridas manualmente
--Também podemos criá-las manualmente, utilizando o comando CREATE STATISTICS

CREATE STATISTICS St_id_nome_1
ON PESSOA (ULTIMO_NOME);

CREATE STATISTICS St_id_nome_2
ON PESSOA (Titulo,ULTIMO_NOME);

--VERIFICANDO STATISTICS
EXEC sp_helpstats 'PESSOA', 'all'

--verificando tabela de estatisticas
SELECT * FROM sys.stats 
WHERE object_id = OBJECT_ID('PESSOA')


--Atualizando estatísticas de uma tabela
UPDATE STATISTICS PESSOA


--apagando statistics
--DROP STATISTICS tabela.nome_stats
DROP STATISTICS PESSOA.St_id_nome_2

--Atualizando estatística do banco todo
USE CURSO
GO
sp_updatestats

--RECOMENDADO JANELA PARA EXECUTAR