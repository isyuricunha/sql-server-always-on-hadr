 --1. Habilitar o DB Mail
USE master 
GO 
sp_configure 'show advanced options',1 
GO 
RECONFIGURE WITH OVERRIDE 
GO 
sp_configure 'Database Mail XPs', 1 --1 ligado 0 desligado 
GO 
RECONFIGURE  
GO  
 
 
-- verificando log de Emails
use msdb
select sent_status ,* from sysmail_allitems 

--Apagando log de todos emails enviados
EXECUTE msdb.dbo.sysmail_delete_mailitems_sp   
    @sent_status = 'sent' ;  
--Apagando log de todos emails com falha
EXECUTE msdb.dbo.sysmail_delete_mailitems_sp   
    @sent_status = 'failed' ;  

