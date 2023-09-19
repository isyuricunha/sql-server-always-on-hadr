CREATE FUNCTION [dbo].[udfCalcularIdade] (@dtDataNascimento DATETIME, @dtFinal DATETIME)
RETURNS INT
AS BEGIN
    RETURN DATEDIFF(YEAR, @dtDataNascimento, @dtFinal) + CASE WHEN (MONTH(@dtDataNascimento) > MONTH(@dtFinal) OR (MONTH(@dtDataNascimento) = MONTH(@dtFinal) AND DAY(@dtDataNascimento) > DAY(@dtFinal))) THEN -1 ELSE 0 END
END
