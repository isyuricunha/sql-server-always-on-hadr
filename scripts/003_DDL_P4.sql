--CRIACAO DE VIEW
use AULA_DDL
go
CREATE VIEW v_colaborador
	AS
	SELECT * FROM colaborador;

--ALTER VIEW
	ALTER VIEW v_colaborador
	AS 
	SELECT matricula,NOME FROM colaborador

--Excluindo VIEW
DROP VIEW v_colaborador; 
--Excluindo index
DROP index ix_func1 ON colaborador;
--CRIANDO INDEX
CREATE INDEX IX_FUNC1 ON colaborador (NOME)
--Excluindo procedure
DROP PROCEDURE proc_salario; 
--Excluindo Função
DROP function func_salario;
--Excluindo Trigger
DROP trigger trig_func_salario;

--VERIFICANDO DADOS
SELECT * FROM  sys.databases;
--DDL TRUNCATE
SELECT * into informacoes from sys.databases;
-- verifcando dados;

select * from informacoes;

--DDL TRUNCATE VERIFICANDO
--FAZENDO BK EM TABELA TEMPORARIA
SELECT * INTO #temp_info FROM informacoes;
--VERIFCANDO REGISTRO TABELA TEMPORARIA


SELECT * FROM #temp_info;

--ANALISE DE REGISTROS ANTES DO TRUNCATE
SELECT Count(*) AS AntesTruncateCount 
FROM   informacoes; 

--DDL TRUNCATE APAGAR DADOS DA TABELA
TRUNCATE TABLE informacoes;
 
--VERIFICANDO TABELAS APOS TRUNCATE
SELECT Count(*) AS DepoisTruncateCount 
FROM   informacoes; 

--POPULANDO A TABELA COM DADOS DA TABELA TEMPORARIA
 insert into informacoes
 select * from #temp_info
--verificando registro 
 select * from informacoes;


--ELIMINANDO A TEMP

DROP TABLE #temp_info


