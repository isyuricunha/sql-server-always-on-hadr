CREATE FUNCTION formata_CPF_CNPJ(@nDocumento char(14)) 
RETURNS CHAR(18) 
AS 
BEGIN 
DECLARE @formatado VARCHAR(18) 
IF LEN(@nDocumento) = 14 BEGIN
    SET
        @formatado = SUBSTRING(@nDocumento, 1, 2) + '.' + SUBSTRING(@nDocumento, 3, 3) + '.' + SUBSTRING(@nDocumento, 6, 3) + '/' + SUBSTRING(@CnpjCpf, 9, 4) + '-' + SUBSTRING(@CnpjCpf, 13, 2)
    END
    ELSE BEGIN
    SET
        @formatado = SUBSTRING(@nDocumento, 1, 3) + '.' + SUBSTRING(@nDocumento, 4, 3) + '.' + SUBSTRING(@nDocumento, 7, 3) + '-' + SUBSTRING(@CnpjCpf, 10, 2)
    END RETURN @formatado
END
