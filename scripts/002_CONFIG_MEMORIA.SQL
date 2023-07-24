--Verificando parametro de memória maxima
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 
WHERE a.name = 'max server memory (MB)'

--Verificando todos parâmetros
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 

--Defina a opção de memória máxima do servidor como 4 GB.

	sp_configure 'show advanced options', 1;
	GO
	RECONFIGURE;
	GO
	sp_configure 'max server memory', 4096;
	GO
	RECONFIGURE;
	GO
	sp_configure 'show advanced options', 0;
	GO
	RECONFIGURE;

--VERIFICANDO ATUALIZAÇÃO DO PARAMETRO DE MEMÓRIA MÁXIMA
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 
WHERE a.name = 'max server memory (MB)'