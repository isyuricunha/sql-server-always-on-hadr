--Indentificando arquivo trace
SELECT * FROM sys.traces;


--verificando arquivo TRACE
SELECT  TextData, 
		SPID, 
		LoginName, 
		NTUserName, 
		NTDomainName, 
		HostName, 
		ApplicationName, 
		StartTime, ServerName, 
		DatabaseName, 
		EventClass, 
		ObjectType
	
FROM fn_trace_gettable('C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER001\MSSQL\Log\log_63.trc', default)
where TextData is not null
and LoginName='DBA_CURSO'






