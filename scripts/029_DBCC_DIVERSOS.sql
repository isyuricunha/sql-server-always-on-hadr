--Retorna informações de sintaxe para o comando especificado DBCC.
DBCC HELP (TRACEON)
DBCC HELP (CHECKTABLE)
DBCC HELP (CHECKDB)

--Descarrega o procedimento armazenado estendido DLL especificado da memória
DBCC dllname (FREE)

--select * from sys.session
--https://docs.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql?view=sql-server-2017#examples
--Habilita os sinalizadores de rastreamento especificados
DBCC TRACEON 
--Rastreia sINALIZADOR 2528,3205
DBCC TRACEON  (2528, 3205);  
----Exibe o status de sinalizadores de rastreamento
DBCC TRACESTATUS
--O exemplo a seguir exibe o estado de todos os sinalizadores de rastreamento atuais habilitados globalmente.
DBCC TRACESTATUS(-1);  
GO 
--O exemplo a seguir exibe o status dos indicadores de rastreamento 2528 e 3205.
DBCC TRACESTATUS (2528, 3205);  
GO  
--Desabilita os sinalizadores de rastreamento especificados.
DBCC TRACEOFF 

--Desabilita sinalizadores de rastreamento 2528,3205
DBCC TRACEOFF  (2528, 3205);  
--apoio 
