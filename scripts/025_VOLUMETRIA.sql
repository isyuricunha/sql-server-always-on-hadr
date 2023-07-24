USE AdventureWorks2017
--Verificando tamanho/espaço ocupado pelos banco de dados
exec sp_databases

select 344064/1024
--Verificando tamanho/espaço ocupado pelos banco de dados
USE AdventureWorks2017
exec sp_spaceused 'Person.Person'
exec sp_spaceused 'Production.Product'

--verificando todas tabelas registros e tamanho
USE AdventureWorks2017
--1 Página de dados do SQL Server é 8 kb
--1 MB armazena 128 páginas de dados.
SELECT o.name,
p.Rows As Linhas,
    SUM(a.Total_Pages * 8) As Reservado,
    SUM(CASE WHEN p.Index_ID > 1 THEN 0 ELSE a.Data_Pages * 8 END) As Dados,
        SUM(a.Used_Pages * 8) -
        SUM(CASE WHEN p.Index_ID > 1 THEN 0 ELSE a.Data_Pages * 8 END) As Indice,
    SUM((a.Total_Pages - a.Used_Pages) * 8) As NaoUtilizado,
	SUM(a.Total_Pages) Paginas_reservadas,
	SUM(a.Data_Pages)  Paginas_Usadas
FROM
    sys.partitions As p
    INNER JOIN sys.allocation_units As a 
	ON p.hobt_id = a.container_id
	INNER JOIN sys.objects O
	ON O.object_id=P.object_id
	WHERE O.type='U' -- TABELAS DO USUARIOS
GROUP BY o.name,Rows
ORDER BY dados desc

--verificando tamanhos de arquivos
select DB_NAME(dbid)bd,
       cast(cast(size*8 as decimal(10,2))/1024. as decimal(10,3))tamanho,
	   STR (size * 8, 15, 0) + ' KB' tamanho_str,
	   name, 
	   filename
	   from sysaltfiles 

--VERIFICANDO TAMANHO BANCO
--VERIFCAR TAMANHO DO ARQUIVO
SELECT DB.name, SUM(size) * 8 AS Tamanho ,
                SUM(size) * 8 /1024 AS Tamanho_MB 
FROM sys.databases DB
INNER JOIN sys.master_files
ON DB.database_id = sys.master_files.database_id
GROUP BY DB.name

--SELECT 344064/1024
