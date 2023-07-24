-- Conex�es ativas
SELECT datediff(MINUTE,a.connect_time,GETDATE()) minutos_conectado, a.* 
FROM sys.dm_exec_connections a
 
-- Sess�es ativas
SELECT datediff(MINUTE,a.login_time,GETDATE()) minutos_conectado,a.* 
FROM sys.dm_exec_sessions a
 
-- Requisi��es solicitadas
SELECT * FROM sys.dm_exec_requests




