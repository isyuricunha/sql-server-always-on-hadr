/*
	Abaixo tem 3 registros onde tem um ou mais e-mails para o mesmo cliente
	onde a separação dos e-mails não está padronizado.
	É necessário pegar somente o primeiro e-mail de cada cliente.

	Resultado esperado:
	idCliente	primeiroEmail
	1			emaildeteste1@teste.com.br
	2			emaildeteste3@teste.com.br
	3			emaildeteste5@teste.com.br
	4			emaildeteste6@teste.com.br
*/

DECLARE @tb_CLIENTE AS TABLE (idCliente int, email VARCHAR(120))

INSERT INTO @tb_CLIENTE 
	VALUES 
		(1 , 'emaildeteste1@teste.com.br/emaildeteste2@teste.com.br'),
		(2 , 'emaildeteste3@teste.com.br emaildeteste4@teste.com.br'),
		(3 , 'emaildeteste5@teste.com.br'),
		(4 , 'emaildeteste6@teste.com.br; emaildeteste7@teste.com.br')

SELECT 
	 idCliente,  
	 CASE 
		WHEN email LIKE '%;%' THEN 
			SUBSTRING(email, 1, CHARINDEX(';', REPLACE(REPLACE(email, ' ', ';'), '/', ';'), 1) - 1) 
		WHEN email LIKE '% %' THEN 
			SUBSTRING(email, 1, CHARINDEX(';', REPLACE(REPLACE(email, ' ', ';'), '/', ';'), 1) - 1)  
		WHEN email LIKE '%/%' THEN 
			SUBSTRING(email, 1, CHARINDEX(';', REPLACE(REPLACE(email, ' ', ';'), '/', ';'), 1) - 1) 
		ELSE
			RTRIM(LTRIM(email))
	 END AS EMAIL
FROM @tb_CLIENTE 
