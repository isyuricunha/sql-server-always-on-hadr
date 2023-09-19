/*
	Abaixo as tabelas A e B tem informações de CNPJs e nome de empresaS diferentes uma da outra.
	É necessário unir as informações das duas tabelas em uma única e criar uma nova tabela C com as informações unidas.

	Resultado esperado tabela temporária: | Resultado esperado tabela salva no banco: 
	CNPJ		nomeEmpresa	      | CNPJ		nomeEmpresa
	00000000000191	EMPRESA A01	      | 00000000000191	EMPRESA A01
	00000000000192	EMPRESA A02	      | 00000000000192	EMPRESA A02	
	00000000000193	EMPRESA A03	      | 00000000000193	EMPRESA A03
	00000000000291	EMPRESA B01	      | 00000000000291	EMPRESA B01	
	00000000000292	EMPRESA B02	      | 00000000000292	EMPRESA B02	
	00000000000293	EMPRESA B03	      | 00000000000293	EMPRESA B03
*/
	DECLARE @tb_A AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
	DECLARE @tb_B AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))
	DECLARE @tb_C_temporaria AS TABLE (CNPJ VARCHAR(14), nomeEmpresa VARCHAR(100))

	INSERT INTO @tb_A 
		VALUES  
			('00000000000191', 'EMPRESA A01'),
			('00000000000192', 'EMPRESA A02'),
			('00000000000193', 'EMPRESA A03')
	
	INSERT INTO @tb_B 
		VALUES  
			('00000000000291', 'EMPRESA B01'),
			('00000000000292', 'EMPRESA B02'),
			('00000000000293', 'EMPRESA B03')
	
	--Inserindo as informações em uma tabela temporária.
	INSERT INTO @tb_C_temporaria  
				SELECT * FROM (
					 SELECT * FROM @tb_A 
					 UNION
					 SELECT * FROM @tb_B 
				) AS T

	--Listando as informações adicionadas na tabela temporária
	SELECT * FROM @tb_C_temporaria 

	--Criando uma nova tabela no banco de dados com as informações das tabelas A e B
	SELECT * INTO tb_criadaNoBanco FROM (
		SELECT * FROM @tb_A 
		UNION
		SELECT * FROM @tb_B 
	) AS T

	--Listando as informações adicionadas na tabela 
	SELECT * FROM tb_criadaNoBanco
