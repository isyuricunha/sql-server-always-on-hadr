--1. No SSMS, execute os seguintes comandos:
--DROP TABLE TAB_1
--DROP TABLE TAB_2
USE CURSO
CREATE TABLE TAB_1 (CAMPO1 int)
CREATE TABLE TAB_2 (CAMPO1 int)
INSERT TAB_1 VALUES (1)
INSERT TAB_2 VALUES (5)

--VERIFICANDO CONFIG DO SERVIDOR
SELECT * FROM SYS.configurations

--OBSERVAÇÃO EXECUTAR PASSO 2 E 3 QUASE QUE AO MESMO TEMPO. 
--2. Abrir outra sessão e execute os seguintes comandos:
BEGIN TRAN
	UPDATE TAB_1 SET CAMPO1 = 11 WHERE CAMPO1 = 1
	WAITFOR DELAY '00:00:20'
	UPDATE TAB_2 SET CAMPO1 = 55 WHERE CAMPO1 = 5
COMMIT
--3. Abrir outra sessão e execute os seguintes comandos:
BEGIN TRAN
UPDATE TAB_2 SET CAMPO1 = 111 WHERE CAMPO1 = 5
WAITFOR DELAY '00:00:20'
UPDATE TAB_1 SET CAMPO1 = 555 WHERE CAMPO1 = 1
COMMIT


--ANALISANDO 
SELECT
        L.request_session_id AS SPID,
        DB_NAME(L.resource_database_id) AS DatabaseName,
        O.Name AS LockedObjectName,
        P.object_id AS LockedObjectId,
        L.resource_type AS LockedResource,
        L.request_mode AS LockType,
        ST.text AS SqlStatementText,       
        ES.login_name AS LoginName,
        ES.host_name AS HostName,
        TST.is_user_transaction as IsUserTransaction,
        AT.name as TransactionName,
        CN.auth_scheme as AuthenticationMethod
FROM   
  sys.dm_tran_locks L
        JOIN sys.partitions P ON P.hobt_id = L.resource_associated_entity_id
        JOIN sys.objects O ON O.object_id = P.object_id
        JOIN sys.dm_exec_sessions ES ON ES.session_id = L.request_session_id
        JOIN sys.dm_tran_session_transactions TST ON ES.session_id = TST.session_id
        JOIN sys.dm_tran_active_transactions AT ON TST.transaction_id = AT.transaction_id
        JOIN sys.dm_exec_connections CN ON CN.session_id = ES.session_id
        CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
WHERE  
  resource_database_id = db_id()
ORDER BY
  L.request_session_id;


SP_WHO2 