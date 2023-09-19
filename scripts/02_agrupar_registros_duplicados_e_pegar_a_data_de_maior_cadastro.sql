/*
	Abaixo tem 6 registros onde existe CNPJs duplicados mas com a data de cadastro diferente.
	É necessário extrair somente os CNPJs onde a data de cadastro é maior.

	Resultado esperado:
	cnpj				dataCadastro
	00.000.000/0002-22	06/07/2011
	00.000.000/0001-11	07/05/2017
	00.000.000/0003-33	07/18/2019
*/

DECLARE @TB_TABELA AS TABLE (cnpj varchar(20), dataCadastro DATE)

INSERT INTO @TB_TABELA 
	VALUES  
		('00.000.000/0001-11', '30/01/2014'),	
		('00.000.000/0001-11', '05/07/2017'),	
		('00.000.000/0002-22', '07/06/2011'),	
		('00.000.000/0002-22', '05/06/2015'),	
		('00.000.000/0003-33', '18/07/2019'),	
		('00.000.000/0003-33', '08/07/2019') 

SELECT 
	 cnpj, 
	 MAX(CONVERT(VARCHAR(10), dataCadastro, 101)) as dataCadastro

FROM @TB_TABELA 
GROUP BY cnpj
ORDER BY dataCadastro ASC
