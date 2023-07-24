--https://docs.microsoft.com/pt-br/sql/t-sql/functions/serverproperty-transact-sql?view=sql-server-2017

SELECT SERVERPROPERTY('productversion')Versao_Produto, 
       SERVERPROPERTY ('productlevel')Nivel_versao,
       SERVERPROPERTY ('edition') Edicao,
	   SERVERPROPERTY('InstanceDefaultDataPath')LOCALDADOS,
	   SERVERPROPERTY('InstanceDefaultLogPath')LOCALOGS,
	   SERVERPROPERTY('InstanceName')INSTANCIA,
	   SERVERPROPERTY('IsHadrEnabled')HADR,
	   SERVERPROPERTY('LCID')LOCALIZACAO,
	   SERVERPROPERTY('ServerName')SERVERNAME
--VERIFCANDO LANGAGUES

SELECT * FROM SYS.syslanguages

--https://docs.microsoft.com/pt-br/sql/t-sql/functions/configuration-functions-transact-sql?view=sql-server-2017
--Verificando informa��es do servidor
Select @@version 
--Retorna o nome do idioma que est� sendo usado atualmente.
SELECT @@LANGUAGE
--VERIFICANDO TRANSA��ES ABERTAS
SELECT @@TRANCOUNT
--Retorna o nome do servidor local que est� executando o SQL Server.
SELECT @@SERVERNAME
--Retorna o nome da chave do Registro na qual o SQL Server est� sendo executado. @@SERVICENAME retornar� 'MSSQLSERVER'
SELECT @@SERVICENAME
--Retorna a ID de sess�o do processo de usu�rio atual.
SELECT @@SPID


