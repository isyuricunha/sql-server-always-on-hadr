/*
	Abaixo tem duas tabelas A e B, na A tem 3 registros de CNPJs e 
	na B tem dois registros repetidos na A. 
	É necessário identificar qual CNPJ da tabela A não existe na tabela B.

	Resultado esperado:
	1-Apresentar o CNPJ 00000000000193 que não existe na tabela B
	CNPJ
	00000000000193
*/

	DECLARE @tb_CLIENTE_A AS TABLE (CNPJ VarChar(14))
	DECLARE @tb_CLIENTE_B AS TABLE (CNPJ VarChar(14))

	INSERT INTO @tb_CLIENTE_A 
		VALUES  ('00000000000191'),
			('00000000000192'),
			('00000000000193')
	
	INSERT INTO @tb_CLIENTE_B 
		VALUES  ('00000000000191'),
			('00000000000192') 
	
	--Retorna o único CNPJ que não tem na tabela B (193)
	SELECT * FROM @tb_CLIENTE_A 
	EXCEPT 
	SELECT * FROM @tb_CLIENTE_B

	--Não irá retornar registos, pois os dois CNPJs já existe na tabela A	 
	SELECT * FROM @tb_CLIENTE_B
	EXCEPT 
	SELECT * FROM @tb_CLIENTE_A
