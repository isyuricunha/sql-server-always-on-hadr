CREATE FUNCTION formatarCNPJCPF(@CnpjCpf char(14))
RETURNS CHAR(18)
AS
BEGIN
	DECLARE @retorno VARCHAR(18)

	IF LEN(@CnpjCpf)= 14 
		BEGIN
			SET @retorno = SUBSTRING(@CnpjCpf ,1,2) + '.' + SUBSTRING(@CnpjCpf ,3,3) + '.' + SUBSTRING(@CnpjCpf ,6,3) + '/' + SUBSTRING(@CnpjCpf ,9,4) + '-' + SUBSTRING(@CnpjCpf ,13,2)
		END 
	ELSE 
		BEGIN
		     SET @retorno = SUBSTRING(@CnpjCpf ,1,3) + '.' + SUBSTRING(@CnpjCpf ,4,3) + '.' + SUBSTRING(@CnpjCpf ,7,3) + '-' + SUBSTRING(@CnpjCpf ,10,2) 
		END

		RETURN @retorno
	END