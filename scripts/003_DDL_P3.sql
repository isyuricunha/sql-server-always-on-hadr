--Adicionando novo campo na tabela 
 ALTER TABLE colaborador ADD genero CHAR(1); 
 
 --Renomeando campo da tabela
 --EXEC sp_rename 'TABELA_ORIGEM.CAMPO_ORIG', 'Campo_orig', 'COLUMN'

EXEC Sp_rename 'colaborador.endereco', 'ender', 'COLUMN' 

--Alterando tipo da coluna
ALTER TABLE colaborador ALTER COLUMN ender VARCHAR(60);
   
--Excluindo campo da coluna
ALTER TABLE colaborador DROP COLUMN genero; 

--Excluindo chave estrangeira
ALTER TABLE salario
DROP CONSTRAINT [CK__salario__salario__403A8C7D]; --DE ACORDO COM SEU AMBIENTE
   
--Renomeando Tabela
--EXEC sp_rename   'Nome Antigo', 'Nome Novo'
EXEC Sp_rename   'colaborador','FUNC';

EXEC Sp_rename   'FUNC','colaborador';


--Excluindo tableE OUTROS OBJETOS
DROP TABLE salario;
--PROCEDURE
DROP PROCEDURE NOME_PROC

--FUNCTION
DROP FUNCTION NOME_FUNCAO

--VIEW
DROP VIEW NOME_VIEW

--TRIGGER
DROP TRIGGER NOME_TRIGGER

--INDEX
DROP INDEX NOME_INDEX ON NOME_TABELA
