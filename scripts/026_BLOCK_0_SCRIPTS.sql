--CRIANDO UMA TABELA DE CONTA CORRENTE
USE CURSO
--drop table SALDO_CORRENTE
CREATE TABLE SALDO_CORRENTE
    (ID_CONTA VARCHAR(10),
	 ID_AGENCIA VARCHAR(40),
	 ID_CLIENTE INT,
	 SALDO DECIMAL(10,2)
	 )
--INSERINDO DADOS
INSERT INTO SALDO_CORRENTE VALUES ('100001','9000',1,1000)
INSERT INTO SALDO_CORRENTE VALUES ('100002','9001',1,1000)

--VERIFICANDO LOCK, BLOCKS E DEADLOCK
-- Procedures Nativas para verificar processos.

sp_who2 

sp_Lock
--Retorna informações sobre os recursos de gerenciador de bloqueio ativos atualmente 
--no SQL Server 2017. Cada linha representa uma solicitação ativa no momento para o 
--gerenciador de um bloqueio que foi concedido ou que está aguardando concessão.

select * from sys.dm_tran_locks a
--Contém informações sobre os processos que estão em execução em uma instância do SQL Server. 
--Eles podem ser processos do cliente ou processos do sistema
select * from sys.SYSPROCESSES 
--Filtrada por block
select spid, blocked, hostname=left(hostname,20), program_name=left(program_name,20),
       WaitTime_Seg = convert(int,(waittime/1000))  ,open_tran, status
From master.dbo.sysprocesses 
where blocked > 0
order by spid
--
--após identificar a conexão que está te bloqueado use para ver o comando que está em execução.
DBCC INPUTBUFFER(61) 

--SE REALMANTE NECESSARIO MATAR O PROCESSO
KILL 58   --numero do processo
--VIEW PARA ANAISE DE PROCESSOS
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

--SELECT @@TRANCOUNT