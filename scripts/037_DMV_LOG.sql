
--DESCOBRINDO ID DO BANCO

SELECT * FROM sys.sysdatabases
--ENFASE ARQUIVOS DE LOG
--Este DMV retorna informações sobre os arquivos de log de transações. 
--As informações incluem o modelo de recuperação do banco de dados.
select 
	 db_NAME(database_id) dbname,
	 recovery_model,
	 current_vlf_size_mb,
	 total_vlf_count,
	 active_vlf_count,
	 active_log_size_mb,
	 log_truncation_holdup_reason,
	 log_since_last_checkpoint_mb
  from 
	sys.dm_db_log_Stats(5) --PRECISA DE PARAMETRO ID DO BANCO

--AJUSTANDO O PARAMETRO DA DMV PARA RETORNAR TODOS OS BANCOS
select 
	 A.name,
	 B.recovery_model,
	 B.current_vlf_size_mb,
	 B.total_vlf_count,
	 B.active_vlf_count,
	 B.active_log_size_mb,
	 B.log_truncation_holdup_reason,
	 B.log_since_last_checkpoint_mb
  from 
  sys.databases AS A
  CROSS APPLY sys.dm_db_log_Stats(A.database_id) B
  where A.database_id=B.database_id

--Essa exibição analisa especificamente arquivos de log virtuais ou VLFs. Eles compõem o 
--log de transações do banco de dados,ter um grande número de VLFs pode afetar 
--negativamente o tempo de inicialização e recuperação do banco de dados. , 
--Esta view retorna quantas VLFs seu banco de dados possui atualmente, 
--juntamente com seu tamanho e status.
  select 
		 db_NAME(database_id) dbname,
		 file_id,
		 vlf_begin_offset,
		 vlf_size_mb,
		 vlf_sequence_number,
		 vlf_active,
		 vlf_status
	 from 
		sys.dm_db_log_info(5) b --AJUSTANDO O PARAMETRO DA DMV PARA RETORNAR TODOS OS BANCOS

--
--A configuração correta do log de transações é crítica para o desempenho do banco de dados. 
--O log grava todas as transações antes de enviá-las para o arquivo de dados. Em muitos casos, 
--os logs de transações crescem significativamente. Gerenciar e entender como o log de transações 
--está crescendo fornece uma boa indicação sobre o desempenho do sistema. 
 
WITH DATA_VLF AS(
SELECT 
DB_ID(a.[name]) AS DatabaseID,
a.[name] AS dbName, 
CONVERT(DECIMAL(18,2), c.cntr_value/1024.0) AS [Log Size (MB)],
CONVERT(DECIMAL(18,2), b.cntr_value/1024.0) AS [Log Size Used (MB)]
FROM sys.databases AS a WITH (NOLOCK)
INNER JOIN sys.dm_os_performance_counters AS b  WITH (NOLOCK) ON a.name = b.instance_name
INNER JOIN sys.dm_os_performance_counters AS c WITH (NOLOCK) ON a.name = c.instance_name
WHERE b.counter_name LIKE N'Log File(s) Used Size (KB)%' 
AND c.counter_name LIKE N'Log File(s) Size (KB)%'
AND c.cntr_value > 0 
)

SELECT	[dbName],
		[Log Size (MB)], 
		[Log Size Used (MB)], 
		[Log Size (MB)]-[Log Size Used (MB)] [Log Free (MB)], 
		cast([Log Size Used (MB)]/[Log Size (MB)]*100 as decimal(10,2)) [Log Space Used %],
		COUNT(b.database_id) AS [Number of VLFs] ,
		sum(case when b.vlf_status = 0 then 1 else 0 end) as Free,
		sum(case when b.vlf_status != 0 then 1 else 0 end) as InUse		
FROM DATA_VLF AS a  
CROSS APPLY sys.dm_db_log_info(a.DatabaseID) b
GROUP BY dbName, [Log Size (MB)],[Log Size Used (MB)]


--DBCC PARA LOGS
--POR BANCO DE DADOS
DBCC LOGINFO