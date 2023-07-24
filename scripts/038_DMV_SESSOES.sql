-- Conexões ativas
SELECT datediff(MINUTE,a.connect_time,GETDATE()) minutos_conectado, a.* 
FROM sys.dm_exec_connections a
 
-- Sessões ativas
SELECT datediff(MINUTE,a.login_time,GETDATE()) minutos_conectado,a.* 
FROM sys.dm_exec_sessions a
 
-- Requisições solicitadas
SELECT * FROM sys.dm_exec_requests




