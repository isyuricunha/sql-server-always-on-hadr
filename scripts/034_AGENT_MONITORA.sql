--Podemos conseguir informações de JOBs através de T-SQL 
--dando um SELECT nas tabelas SYSJOBHISTORY e SYSJOBS do banco de dados MSDB.

Use MSDB
GO
select * from dbo.sysjobhistory

Use MSDB
GO
select * from dbo.sysjobs

--OU chamar a STORED PROCEDURE SP_HELP_JOBHISTORY. 
--Veja abaixo um exemplo de como utilizar essa stored procedure.


USE MSDB
GO
--RETORNA HISTORICO DE JOBS
EXEC sp_help_jobhistory @job_name='Backup FULL Curso'

USE MSDB
GO
--RETORNA O JOBS ATIVOS
EXEC sp_help_jobactivity @job_name='Backup FULL Curso'

--RETORNA AGENDAMENTO JOBS 
USE MSDB
GO
EXEC sp_help_jobschedule  @job_name='Backup FULL Curso'

