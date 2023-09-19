/*
	Na table @tb_CLIENTE tem 8 CNPJs, alguns deles estão duplicados.
	É necessário pegar somente os CNPJs que estão duplicados e a quantidade da repetição.

	Resultado:
	CNPJsDuplicados		QTD
	00000000000191		2
	00000000000192		2
	00000000000193		3
*/

DECLARE @tb_CLIENTE AS TABLE (idCliente int, CNPJ VARCHAR(14)) 

INSERT INTO @tb_CLIENTE 
	VALUES 
		(1, '00000000000191'),
		(2, '00000000000192'),
		(3, '00000000000191'),
		(4, '00000000000193'),
		(5, '00000000000193'),
		(6, '00000000000193'),
		(7, '00000000000196'),
		(8, '00000000000192'),
		(9, '00000000000194'),
		(10, '00000000000195')

SELECT  
	 CNPJ AS CNPJsDuplicados,
	 Count(*) QTD
FROM @tb_CLIENTE 
GROUP BY  CNPJ
HAVING Count(*) > 1
