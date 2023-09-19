/*
	Abaixo tem 6 registros com números de telefones onde uns tem ddd e outros não.
	É preciso extrair separadamente o ddd, telefone dos registros abaixo.

	Resultado esperado:
	ddd telefone	dddETelefone
	66	12345678	6612345678 
	66	12345678	12345678   
	66	12345678	6612345678 
	65	912345678	65912345678
	66	12345678	6612345678 
*/

DECLARE @TB_TABELA AS TABLE (telefone varchar(20))

INSERT INTO @TB_TABELA 
	VALUES  
		('6612345678 '),
		('12345678   '),
		('6612345678 '),
		('           '),
		('65912345678'),
		('6612345678 ')
		
	SELECT 
		CASE 
			WHEN LEN(RTRIM(LTRIM(telefone))) = 8 THEN '66'  
			WHEN LEN(RTRIM(LTRIM(telefone))) = 9 THEN '66' 
			WHEN LEN(RTRIM(LTRIM(telefone))) = 10 THEN SUBSTRING(telefone, 1, 2)  
			WHEN LEN(RTRIM(LTRIM(telefone))) = 11 THEN SUBSTRING(telefone, 1, 2)  
		END AS ddd,
		CASE 
			WHEN LEN(RTRIM(LTRIM(telefone))) = 8 THEN RTRIM(LTRIM(telefone))
			WHEN LEN(RTRIM(LTRIM(telefone))) = 9 THEN RTRIM(LTRIM(telefone))
			WHEN LEN(RTRIM(LTRIM(telefone))) = 10 THEN SUBSTRING(telefone, 3, 8)  
			WHEN LEN(RTRIM(LTRIM(telefone))) = 11 THEN SUBSTRING(telefone, 3, 9)  
		END AS telefone,
		telefone as dddETelefone

	FROM @TB_TABELA  
	WHERE telefone <> ''
