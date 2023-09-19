/*
	Abaixo tem 4 registros de cliente, onde cada um tem nenhum ou um ou mais e-mails,
	os e-mails não estão com um padrão de separação. É necessário separar 
	esses e-mails por cliente.

	Resultado esperado:
	idCliente|emailSeparado
	1		 |carro_1@gmail.com
	1		 |carro_2@terra.com.br
	2		 |moto_1@gmail.com
	2		 |moto_2@terra.com.br 
	3		 |aviao_1@gmail.com
	3		 |aviao_2@terra.com.br
	3		 |aviao_3@terra.com.br
	3		 |aviao_4@terra.com.br
*/

DECLARE @tb_EMAIL AS TABLE (idCliente INT, email VARCHAR(120))

INSERT INTO @tb_EMAIL 
	VALUES  (1, 'carro_1@gmail.com; carro_2@terra.com.br'),
			(2, 'moto_1@gmail.com/moto_2@terra.com.br;aviao_3htesgdjdh '),
			(3, 'aviao_1@gmail.com/ aviao_2@terra.com.br; aviao_3@terra.com.br aviao_4@terra.com.br'),
			(4, ' ')

SELECT * FROM (
	SELECT idCliente, A.value AS emailSeparado FROM @tb_EMAIL 
	OUTER APPLY STRING_SPLIT( REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(EMAIL)), ' ', ';'), '/', ';'), ';;', ';'), ';') AS A 
) AS EMAIL
WHERE emailSeparado LIKE '%@%'