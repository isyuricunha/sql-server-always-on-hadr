--https://docs.microsoft.com/pt-br/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2017
--Listando as opções de configuração avançada

USE master;  
GO  
EXEC sp_configure 'show advanced option', '1';  

--Execute RECONFIGURE e exiba todas as opções de configuração:

RECONFIGURE;  
EXEC sp_configure; 
