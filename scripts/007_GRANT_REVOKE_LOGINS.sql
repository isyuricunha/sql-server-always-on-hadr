
SELECT SYSTEM_USER
--CONCEDE ACESSO
GRANT SELECT TO USR_AULA
--REVOGA ACESSO
REVOKE SELECT FROM   USR_AULA


-- Validação do login criado
--------------------------------------------------------------------------------------------------------------------------------
--	Query para ver informações dos logins criados no banco de dados
SELECT	name,
		create_date,
		modify_date,
		LOGINPROPERTY(name, 'DaysUntilExpiration') DiasParaExpirar,
		LOGINPROPERTY(name, 'PasswordLastSetTime') DataUltimaSenha,
		LOGINPROPERTY(name, 'IsExpired') expirado,
		LOGINPROPERTY(name, 'IsMustChange') DeveAlterar,
		is_disabled,
		type_desc,
		*
From sys.sql_logins 
