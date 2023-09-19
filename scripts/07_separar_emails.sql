/*
	Abaixo tem 3 registros onde tem um ou mais e-mail para o mesmo cliente.
	É necessário separar esses e-mail para cada cliente.

	Resultado esperado:
	idCliente	emailSeparado
	1			1_email@gmail.com.br
	2			2_email1@gmail.com.br
	2			2_email2@gmail.com.br
	3			3_email1@gmail.com.br
	3			3_email2@gmail.com.br
	3			3_email3@gmail.com.br
*/

DECLARE @tb_EMAIL AS TABLE (idCliente int, email varchar(120))

	INSERT INTO @tb_EMAIL 
		VALUES  (1, '1_email@gmail.com.br'),
				(2, '2_email1@gmail.com.br;2_email2@gmail.com.br;'),
				(3, '3_email1@gmail.com.br;3_email2@gmail.com.br;3_email3@gmail.com.br;')

	SELECT * FROM (
		SELECT 
			 idCliente,
			 emailSeparado.value as emailSeparado
		FROM @tb_EMAIL
		OUTER APPLY STRING_SPLIT(email,';') AS emailSeparado
	) AS T
	WHERE emailSeparado <> ''

-- Caso apresente a Msg 208... Nome de objeto 'string_split' inválido.
-- executa o comando abaixo
--- ALTER DATABASE [DatabaseName] SET COMPATIBILITY_LEVEL = 130