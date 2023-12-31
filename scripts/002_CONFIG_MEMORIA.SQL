--Verificando parametro de mem�ria maxima
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 
WHERE a.name = 'max server memory (MB)'

--Verificando todos par�metros
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 

--Defina a op��o de mem�ria m�xima do servidor como 4 GB.

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

--VERIFICANDO ATUALIZA��O DO PARAMETRO DE MEM�RIA M�XIMA
SELECT a.name,a.value, a.value_in_use
FROM sys.configurations a 
WHERE a.name = 'max server memory (MB)'