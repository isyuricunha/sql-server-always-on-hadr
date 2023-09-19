/*
	Na table @tb_INTERVALO tem 4 registros de taxas para um determinado número de parcelas.
	Necessário pegar a taxa correta para o cartão através do tipo da taxa junto com a quantidade 
	de parcelas.

*/

DECLARE @tb_PARCELAS AS TABLE (idTaxa int,
  idConta int,
  tipoTaxaCartao char(2),
  valorTaxa decimal(18,2),
  qtdDia int,
  qtdInicial int,
  qtdFinal int)

INSERT INTO @tb_PARCELAS
VALUES
  (1, 1, 'TC', 3.00, 30, 1, 3),
  (1, 1, 'TC', 3.69, 30, 4, 6),
  (1, 1, 'TC', 4.00, 30, 6, 10),
  (1, 1, 'TD', 3.69, 30, 1, 1)

DECLARE @qtdParcela int = 2,
		@tipoTaxaCartao char(2) = 'TC'

SELECT *
FROM @tb_PARCELAS
WHERE	(qtdFinal >= @qtdParcela AND qtdInicial <= @qtdParcela)
  AND (tipoTaxaCartao = @tipoTaxaCartao)
